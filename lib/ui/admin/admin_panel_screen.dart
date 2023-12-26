// TODO: write documentation

// Stdlib
import 'package:flutter/material.dart';

// 3rd party
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Local
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/extensions.dart';
import 'package:inha_masjid/utils/strings.dart';

/// TODO: write documentation
class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  // Functions
  void _onPrayerTimePressed(context, prayerName) async {
    // Open time picker modal view
    var selectedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    // If user cancels the time picker, return
    if (selectedTime == null) return;

    // Prayer time in 0:0 ~ 23:59 range
    print(prayerName);
    print('${selectedTime.hour}:${selectedTime.minute}');

    // Update prayer time on firestore
    var prayerTimeDoc = await FirebaseFirestore.instance.doc('/prayertimes/$prayerName');
    try{
      await prayerTimeDoc.update({
        'hour': selectedTime.hour,
        'minute': selectedTime.minute,
      });
      Fluttertoast.showToast(
        msg: 'Prayer time updated',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print(e);
    }
  }

  // Overrides
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
            // Monthly expense card text
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
            // Monthly expense amount adjustment widget
            Card(
              color: AppColors.cardBackgroundColor,
              elevation: AppDimensions.cardElevation,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: [
                    // Monthly expense amount text field
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
                                fontSize: AppDimensions.adminPanelMonthlyExpenseAmountFontSize,
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
                              fontSize: AppDimensions.adminPanelMonthlyExpenseAmountFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Update monthly expense button
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

            // Prayer times card title
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
            // Prayer times adjustment widget
            Card(
              color: AppColors.cardBackgroundColor,
              elevation: AppDimensions.cardElevation,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: [
                    // Prayer times adjustment buttons fields
                    Center(
                      child: Wrap(
                        spacing: 30,
                        runSpacing: 18,
                        children: [
                          for (var prayerName in AppStrings.prayerNames)
                            Column(
                              children: [
                                // Prayer name text
                                Text(
                                  prayerName.capitalize(),
                                  style: GoogleFonts.manrope(
                                    fontSize: AppDimensions.prayerTimesTextFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),

                                // Prayer time button
                                StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .doc('/prayertimes/$prayerName')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    var fajrTime = snapshot.data!;
                                    var hour = fajrTime['hour'].toString().padLeft(2, '0');
                                    var minute = fajrTime['minute'].toString().padLeft(2, '0');

                                    // Widget with prayer time, when clicked opens a time picker
                                    // (modal view) to adjust the prayer time.
                                    return SizedBox(
                                      width: 140,
                                      child: TextButton(
                                        onPressed: () => _onPrayerTimePressed(context, prayerName),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                              side: const BorderSide(
                                                color: AppColors.textSecondary,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          '$hour:$minute',
                                          style: GoogleFonts.manrope(
                                            textStyle: const TextStyle(
                                              fontSize: AppDimensions.prayerTimesFontSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Update monthly expense button
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

            // Announcement post card title
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
            // Announcement post text content widget
            Card(
              color: AppColors.cardBackgroundColor,
              elevation: AppDimensions.cardElevation,
              child: ExpansionTile(
                expandedAlignment: Alignment.centerLeft,
                shape: Border.all(color: Colors.transparent),
                title: const Text('title'),
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
            // Announcement post button
            Container(
              margin: const EdgeInsets.only(top: 10),
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
          ],
        ),
      ),
    );
  }
}
