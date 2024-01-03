// TODO: write documentation

// Stdlib
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  AdminPanelScreen({super.key});

  // Variables
  final _monthlyExpenseController = TextEditingController();
  final _postNewAnnouncementTitleController = TextEditingController();
  final _postNewAnnouncementContentController = TextEditingController();

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
    var prayerTimeDoc =
        await FirebaseFirestore.instance.doc('/prayertimes/$prayerName');
    try {
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

  //
  void _updateMonthExpenseBtnPressed(context) {
    // First, check if the text field is not empty
    if (_monthlyExpenseController.text.isEmpty) {
      // Show an error message if the amount is not provided
      Fluttertoast.showToast(
        msg: 'Please enter the monthly expense amount',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return; // Do not proceed further if the amount is not provided
    }

    // birinchi userdan amountni olib firebase ga qo'yish kere
    var amount = int.parse(_monthlyExpenseController.text);

    // keyin amountni olib firebase ga qo'yish kere
    var firestore = FirebaseFirestore.instance;
    firestore.doc("/masjidConfigs/monthlyFee").set({
      "amount": amount,
      "currency": "KRW",
    }).then((_) {
      // Show success message
      Fluttertoast.showToast(
        msg: 'Monthly expense updated successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red, // Change color to indicate success
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Clear the monthly expense text field
      _monthlyExpenseController.clear();
    }).catchError((error) {
      print("Error updating monthly expense: $error");
      // Show error message
      Fluttertoast.showToast(
        msg: 'Error updating monthly expense',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  void _postNewAnnouncementBtnPresses(content) {
    var firestore = FirebaseFirestore.instance;
    var announcementsCollection =
        firestore.collection("announcementsCollection");

    // Your data to be added to the document
    var announcementData = {
      "title": _postNewAnnouncementTitleController.text,
      "content": _postNewAnnouncementContentController.text,
    };

    // Add a new document with the server timestamp
    announcementsCollection.add(announcementData).then((docRef) {
      print("Document written with ID: ${docRef.id}");
      // Show success message
      Fluttertoast.showToast(
        msg: 'Announcement posted successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red, // Change color to indicate success
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Clear text fields
      _postNewAnnouncementTitleController.clear();
      _postNewAnnouncementContentController.clear();
    }).catchError((error) {
      print("Error adding document: $error");
      // Show error message
      Fluttertoast.showToast(
        msg: 'Error posting announcement',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  // Overrides
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // need logic
          },
        ),
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
                    TextField(
                      inputFormatters: <TextInputFormatter>[
                        // for below version 2 use this
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: _monthlyExpenseController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter total amount',
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
                        onPressed: () => _updateMonthExpenseBtnPressed(context),
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
                        spacing: 10,
                        runSpacing: 8,
                        children: [
                          for (var prayerName in AppStrings.prayerNames)
                            Column(
                              children: [
                                // Prayer name text
                                Text(
                                  prayerName.capitalize(),
                                  style: GoogleFonts.manrope(
                                    fontSize:
                                        AppDimensions.prayerTimesTextFontSize,
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
                                    var hour = fajrTime['hour']
                                        .toString()
                                        .padLeft(2, '0');
                                    var minute = fajrTime['minute']
                                        .toString()
                                        .padLeft(2, '0');

                                    // Widget with prayer time, when clicked opens a time picker
                                    // (modal view) to adjust the prayer time.
                                    return SizedBox(
                                      width: 140,
                                      child: TextButton(
                                        onPressed: () => _onPrayerTimePressed(
                                            context, prayerName),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
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
                                              fontSize: AppDimensions
                                                  .prayerTimesFontSize,
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _postNewAnnouncementTitleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        contentPadding: EdgeInsets.only(bottom: 0),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _postNewAnnouncementContentController,
                      decoration: const InputDecoration(
                        labelText: 'Content',
                        contentPadding: EdgeInsets.only(bottom: 0),
                      ),
                    ),
                  ],
                ),
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
                onPressed: () => _postNewAnnouncementBtnPresses(context),
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
