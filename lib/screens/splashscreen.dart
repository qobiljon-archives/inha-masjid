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
    Future.delayed(
      const Duration(milliseconds: 1500),
          () => SharedPreferences.getInstance().then((prefs) {
            final firstTime = true; // prefs.getBool('firstTime') ?? true;
            if (firstTime) {
              Navigator.of(context).pushReplacementNamed('/splashscreen');
            } else {
              Navigator.of(context).pushReplacementNamed('/homepage');
            }
          })

    );

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
      // floatingActionButton: FloatingActionButton(
      //   child: const Text('START'),
      //   onPressed: () {
      //     SharedPreferences.getInstance().then((prefs) {
      //       prefs
      //           .setBool('firstTime', false)
      //           .then((_) => Navigator.of(context).pushReplacementNamed('/'));
      //     });
      //   },
      // ),
    );
  }
}
