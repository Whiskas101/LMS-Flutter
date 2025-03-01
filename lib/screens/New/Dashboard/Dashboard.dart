import 'package:dy_integrated_5/widgets/AdaptiveScaffold.dart';
import 'package:flutter/material.dart';

class DashboardV2 extends StatefulWidget {
  const DashboardV2({super.key});

  @override
  State<DashboardV2> createState() => _DashboardV2State();
}

class _DashboardV2State extends State<DashboardV2> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("data"),
          ],
        ),
      ),
    );
  }
}
