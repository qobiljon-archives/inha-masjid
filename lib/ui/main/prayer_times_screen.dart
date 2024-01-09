// Prayer times screen.

// Stdlib
import 'dart:async';

import 'package:flutter/material.dart';

// 3rd party
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Local
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/extensions.dart';
import 'package:inha_masjid/utils/strings.dart';

// Import the intl package for date formatting
import 'package:intl/intl.dart';

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
  // Variables
  late Timer _timer;
  final DateFormat _dateFormat = DateFormat('HH:mm:ss');
  DateTime _now = DateTime.now();

  // Overrides
  @override
  void initState() {
    super.initState();

    // Update the current time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();

    // Dispose the widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Prepare current time and highlight next prayer time
    DateTime now = DateTime.now();
    String timeStr = _dateFormat.format(now);
    String nextPrayerName;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: BackButton(
          onPressed: widget.onBackButtonPressed,
        ),
        title: Text(
          AppStrings.prayerTimes,
          style: GoogleFonts.manrope(
            fontSize: AppDimensions.screenTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Current time
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.cardPrimaryButtonColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                timeStr,
                style: GoogleFonts.manrope(
                  fontSize: 35,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Prayer times
          Center(
            child: Wrap(
              spacing: 22, // Adjust the spacing between prayer times
              runSpacing: 40, // Adjust the spacing between lines
              children: [
                // Each individual prayer time
                for (var prayerName in AppStrings.prayerNames)
                  Column(
                    children: [
                      Text(
                        prayerName.capitalize(),
                        style: GoogleFonts.manrope(
                          fontSize: AppDimensions.prayerTimesTextFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 140,
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.textSecondary,
                            width: 2.0,
                          ),
                        ),
                        child: StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .doc(FirestorePaths.prayerTimeDoc(prayerName))
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            // Prayer time details
                            var doc = snapshot.data!;
                            int hour = doc['hour'];
                            int minute = doc['minute'];

                            // Highlight if within next 1 hour
                            int deltaMinutes = (hour - now.hour) * 60 + (minute - now.minute);
                            bool nextPrayer = deltaMinutes >= 0 && deltaMinutes <= 60;

                            // Return the prayer time widget
                            return Center(
                              child: Text(
                                '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
                                style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                    fontSize: AppDimensions.prayerTimesFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: nextPrayer
                                        ? AppColors.cardPrimaryButtonColor
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
