import 'package:flutter/material.dart';
import 'package:inha_masjid/screens/homepage.dart';
import 'package:inha_masjid/screens/rootscreen.dart';
import 'package:inha_masjid/screens/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const RootScreen(),
          '/splashscreen': (context) => const SplashScreen(),
          '/homepage': (context) => const HomePage(),
        });
  }
}
