// Home screen. This is the main screen of the application shown both to
// regular users and admins. Regular users can see the donation progress
// bar, recent donations list, and other information about the masjid.
// Admin users can also click on the admin login button to go to admin
// panel, and regular users can click on the `x` button to hide the admin
// login button.

// Stdlib
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          AppStrings.homeScreenTitle,
          style: GoogleFonts.manrope(
            fontSize: AppDimensions.screenTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Are you masjid administrator?'),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.close),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Go to admin page'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
