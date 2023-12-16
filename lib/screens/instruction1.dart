import 'package:flutter/material.dart';

class InstructionOnePage extends StatelessWidget {
  const InstructionOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            FractionallySizedBox(
              widthFactor: 0.12417302799,
              child: Image(
                image: AssetImage(
                  'images/logo_white.png',
                ),
              ),
            ),
            Spacer(),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: Image(
                image: AssetImage(
                  'images/logo_white.png',
                ),
              ),
            ),
            Spacer(),
            Text('Welcome', style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
