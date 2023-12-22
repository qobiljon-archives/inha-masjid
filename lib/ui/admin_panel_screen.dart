// TODO: write documentation

// Stdlib
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';

/// TODO: write documentation
class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

/// TODO: write documentation
class _AdminPanelScreenState extends State<AdminPanelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.adminPanelScreenAppBarTitle,
          style: GoogleFonts.manrope(
            fontSize: AppDimensions.screenTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.adminPanelUpdateMonthlyText,
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.adminPanelUpdateFontSize,
                  ),
                ),
              ),
            ),
            Card(
              color: AppColors.cardBackgroundColor,
              elevation: AppDimensions.cardElevation,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 35,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.textSecondary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            AppStrings.adminPanelUpdateMonthlyExpenseAmount,
                            style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                fontSize: AppDimensions
                                    .adminPanelMonthlyExpenseAmountFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          AppStrings.adminPanelUpdateMonthlyExpenseWonText,
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontSize: AppDimensions
                                  .adminPanelMonthlyExpenseAmountFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.cardButtonBackgroundColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppStrings.adminPanelButtonText,
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.adminLoginButtonTextSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.adminPanelUpdatePrayerTimesText,
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.adminPanelUpdateFontSize,
                  ),
                ),
              ),
            ),
            Card(
              color: AppColors.cardBackgroundColor,
              elevation: AppDimensions.cardElevation,
              child: Wrap(
                spacing: 22,
                children: [
                  for (var prayerTime in AppStrings.prayerTimes)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 22,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        children: [
                          Text(
                            prayerTime['name']!,
                            style: GoogleFonts.manrope(
                              fontSize: AppDimensions.prayerTimesTextFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 120,
                            height: 58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.textSecondary,
                                width: 2.0,
                              ),
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
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.adminPanelUpdatePostText,
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.adminPanelUpdateFontSize,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Card(
                  color: AppColors.cardBackgroundColor,
                  elevation: AppDimensions.cardElevation,
                  child: ExpansionTile(
                    expandedAlignment: Alignment.centerLeft,
                    shape: Border.all(color: Colors.transparent),
                    title: Text('title'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: Text(
                          'content',
                          style: TextStyle(color: AppColors.cardTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.cardButtonBackgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.adminPanelUpdatePostButtonText,
                      style: GoogleFonts.manrope(
                        textStyle: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions.adminLoginButtonTextSize,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.cardButtonBackgroundColorForExit,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.adminPanelUpdateExitButtonText,
                      style: GoogleFonts.manrope(
                        textStyle: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions.adminLoginButtonTextSize,
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
