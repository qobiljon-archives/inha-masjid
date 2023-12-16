import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:inha_masjid/screens/homepage.dart';
import 'package:inha_masjid/screens/instruction1.dart';
import 'package:inha_masjid/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
        backgroundColor: const Color(0xFF235668),
        splash: const Center(
          child: FractionallySizedBox(
            widthFactor: 0.43765903307,
            child: Image(image: AssetImage('images/masjid_logo.png')),
          ),
        ),
        splashIconSize: double.infinity,
        nextRoute: '/instruction1',
        nextScreen: const InstructionOnePage(),
      ),
      routes: {
        '/splashscreen': (context) => const SplashScreen(),
        '/homepage': (context) => const HomePage(),
        '/instruction1': (context) => const InstructionOnePage(),
      },
    );
  }
}
