// Prayer times screen.

// Stdlib
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';

/// TODO write documentation for prayer times screen.
class PrayerTimesScreen extends StatefulWidget {
  // Variables
  final VoidCallback onBackButtonPressed;

  // Functions
  const PrayerTimesScreen({
    super.key,
    required this.onBackButtonPressed,
  });

  // Overrides
  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

/// TODO write documentation for prayer times screen state.
class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          AppStrings.prayerTimesScreenTitle,
          style: GoogleFonts.manrope(
            fontSize: AppDimensions.screenTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: Text('TBD: prayer times screen'),
      ),
    );
  }
}
