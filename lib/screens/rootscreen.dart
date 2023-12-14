import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      final firstTime = prefs.getBool('firstTime') ?? true;
      if (firstTime) {
        Navigator.of(context).pushReplacementNamed('/splashscreen');
      } else {
        Navigator.of(context).pushReplacementNamed('/homepage');
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: Container());
}
