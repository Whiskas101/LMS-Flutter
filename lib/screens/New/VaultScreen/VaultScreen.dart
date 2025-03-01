import 'package:dy_integrated_5/widgets/AdaptiveScaffold.dart';
import 'package:flutter/material.dart';

class VaultScreen extends StatelessWidget {
  const VaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // VAULT Text, with description
        Flexible(
          flex: 3,
          child: Container(
            color: Colors.red,
            // child: Text("Vault"),
          ),
        ),

        // Breakdown section? idk what's the difference
        Flexible(
          flex: 6,
          child: Container(
            color: Colors.green,
          ),
        )
      ],
    );
  }
}
