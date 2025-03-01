import 'dart:ui' as ui;
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class NeonText extends StatefulWidget {
  // const NeonText({super.key});
  final String text;
  final TextStyle style;

  const NeonText({super.key, required this.text, required this.style});

  @override
  State<NeonText> createState() => _NeonTextState();
}

class _NeonTextState extends State<NeonText>
    with SingleTickerProviderStateMixin {
  ui.FragmentShader? _shader;
  late AnimationController _controller;
  late Size _widgetSize;

  Future<void> _loadShader() async {
    final program =
        await ui.FragmentProgram.fromAsset('shaders/neon_shader.frag');
    setState(() {
      _shader = program.fragmentShader();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadShader();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // call back after the frame is ready
      final renderBox = context.findRenderObject() as RenderBox;
      setState(() {
        _widgetSize = renderBox.size;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      assetKey: 'shaders/neon_shader.frag',
      (context, shader, child) {
        return AnimatedSampler(
          enabled: true,
          (frame, size, canvas) {
            final paint = Paint();
            // // for Size information
            shader.setFloat(0, size.width.toDouble());
            shader.setFloat(1, size.height.toDouble());
            // // for time
            shader.setFloat(2, 0.0);

            // for sampler which takes in the widget rendered as an image
            shader.setImageSampler(0, frame);

            paint.shader = shader;
            canvas.drawRect(
              Offset.zero & size,
              Paint()..shader = shader,
            );
          },
          child: Text(
            widget.text,
            style: widget.style.copyWith(color: Colors.red),
          ),
        );
      },
    );
  }
}



    // return _shader == null
    //     ? const Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     : AnimatedBuilder(
    //         animation: _controller,
    //         builder: (context, child) {
    //           return ShaderMask(
    //             shaderCallback: (bounds) {
    //               if (_shader != null && _widgetSize != Size.zero) {
    //                 // setting the uSize uniform
    //                 _shader!.setFloat(0, _widgetSize.width);
    //                 _shader!.setFloat(1, _widgetSize.height);

    //                 //setting the time uniform
    //                 _shader!.setFloat(2, _controller.value * 2 * 3.14);

    //                 // the sampler2d
    //                 // ui.Image img = ;
    //                 // _shader!.setImageSampler(0, )
    //               }
    //               return _shader!;
    //             },
    //             child: Text(
    //               widget.text,
    //               style: widget.style.copyWith(
    //                 color: Colors.red, // This is for the mask
    //               ),
    //             ),
    //           );
    //         },
    //       );