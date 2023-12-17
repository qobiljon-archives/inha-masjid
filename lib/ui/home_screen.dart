// Home screen. This is the main screen of the application shown both to
// regular users and admins. Regular users can see the donation progress
// bar, recent donations list, and other information about the masjid.
// Admin users can also click on the admin login button to go to admin
// panel, and regular users can click on the `x` button to hide the admin
// login button.

// Stdlib
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inha_masjid/utils/colors.dart';
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
          // TODO finish this part
          Card(
            margin: const EdgeInsets.all(15),
            color: AppColors.cardBackgroundColor,
            elevation: AppDimensions.cardElevation,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        AppStrings.homeScreenCardQuestion,
                        style: TextStyle(
                          fontSize: AppDimensions.homeScreenCardFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 77,
                        vertical: 17,
                      ), // Adjust the padding values as needed
                      textStyle: const TextStyle(
                        fontSize: AppDimensions.homeScreenCardFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: AppColors.cardButtonBackgroundColor,
                    ),
                    child: const Text(
                      AppStrings.homeScreenCardTextButton,
                    ),
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
