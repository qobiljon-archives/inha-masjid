// Prayer times screen.

// Stdlib
import 'package:flutter/material.dart';

// 3rd party
import 'package:google_fonts/google_fonts.dart';

// Local
import 'package:inha_masjid/utils/colors.dart';
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

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: BackButton(
          onPressed: widget.onBackButtonPressed,
        ),
        title: Text(
          AppStrings.prayerTimesScreenTitle,
          style: GoogleFonts.manrope(
            fontSize: AppDimensions.screenTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Wrap(
          spacing: 22, // Adjust the spacing between prayer times
          runSpacing: 40, // Adjust the spacing between lines
          children: [
            for (var prayerTime in AppStrings.prayerTimes)
              Column(
                children: [
                  Text(
                    prayerTime['name']!,
                    style: GoogleFonts.manrope(
                      fontSize: AppDimensions.prayerTimesTextFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 160,
                    height: 88,
                    decoration: BoxDecoration(
                      color: AppColors.cardBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        prayerTime['time']!,
                        style: GoogleFonts.manrope(
                          textStyle: const TextStyle(
                            fontSize: AppDimensions.prayerTimesFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
