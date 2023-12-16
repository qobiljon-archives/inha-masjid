import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Move to next screen after some delay
    Future.delayed(
      const Duration(milliseconds: 1500),
      _getNextScreen,
    ).then((route) => Navigator.pushReplacementNamed(context, route));
  }

  Future<String> _getNextScreen() async {
    var prefs = await SharedPreferences.getInstance();
    final firstTime = prefs.getBool('firstTime') ?? true;

    // TODO test and remove '== false' part after finishing instructions
    return firstTime == false ? '/splashscreen' : '/homepage';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF235668), // 235668
        child: const Center(
          child: FractionallySizedBox(
            widthFactor: 0.43765903307,
            child: Image(image: AssetImage('images/masjid_logo.png')),
          ),
        ),
      ),
    );
  }
}
