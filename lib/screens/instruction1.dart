import 'package:flutter/material.dart';

class InstructionOnePage extends StatelessWidget {
  const InstructionOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.1165394402,
              child: Image(
                image: AssetImage(
                  'images/logo_white.png',
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
