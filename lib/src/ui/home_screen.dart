// Home screen. This is the main screen of the application shown both to
// regular users and admins. Admin users can redirect to admin panel from
// this screen by clicking on the admin login button.

// Stdlib
import 'package:flutter/material.dart';

/// Home screen shown to both regular and admin users.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// Home screen state that shows the varying donation progress bar, and
/// recent donations list. Admin users can also click on the admin login
/// button to go to admin panel, and regular users can click on the `x`
/// button to hide the admin login button.
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('TBD: home screen'),
      ),
    );
  }
}
