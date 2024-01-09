// Stdlib
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';
import 'package:flutter/services.dart';

class RecordDonationScreen extends StatefulWidget {
  const RecordDonationScreen({super.key});

  @override
  State<RecordDonationScreen> createState() => _RecordDonationScreenState();
}

class _RecordDonationScreenState extends State<RecordDonationScreen> {
  // Variables
  final _donationAmountController = TextEditingController();
  final _donorNameController = TextEditingController();
  final String _accountNumber = '';

  // Functions
  void _recordMyDonationBtnPressed() {
    // Verify that both fields are not empty
    if (_donorNameController.text.isEmpty || _donationAmountController.text.isEmpty) {
      // Show a message to the user indicating that both fields are required
      Fluttertoast.showToast(
        msg: 'Donor name and donation amount are required',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return; // Exit the method without proceeding to Firestore
    }

    // Donation details
    Timestamp ts = Timestamp.now();
    String donorName = _donorNameController.text;
    int? amount = int.tryParse(_donationAmountController.text);

    // Verify that the amount is a number
    if (amount == null) {
      Fluttertoast.showToast(
        msg: 'Donation amount must be a number (e.g., 1000000)',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        // Change color to indicate error
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return; // Exit the method without proceeding to Firestore
    }

    // Add the donation to Firestore
    var firestore = FirebaseFirestore.instance;
    var donations = firestore.collection(FirestorePaths.donationsCol);
    var donationsData = {
      'timestamp': ts,
      'donorName': donorName,
      'amount': amount,
    };
    donations.add(donationsData).then((docRef) {
      print("Document written with ID: ${docRef.id}");
      Fluttertoast.showToast(
        msg: 'Announcement posted successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        // Change color to indicate success
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Clear text fields
      _donorNameController.clear();
      _donationAmountController.clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppStrings.donate,
          style: GoogleFonts.manrope(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                AppStrings.bankAccountNumber,
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.titleFontSize,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: AppColors.cardBackgroundColor,
              elevation: AppDimensions.cardElevation,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.doc(FirestorePaths.bankAccountDoc).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    // Access the first document in the collection (you may need to adjust this)
                    var document = snapshot.data!;

                    // Access the fields 'accountNumber' and 'bankName' from the document
                    var accountNumber = document['accountNumber'];
                    var bankName = document['bankName'];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$accountNumber',
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontSize: AppDimensions.cardContentFontSize,
                            ),
                          ),
                        ),
                        Text(
                          '$bankName',
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontSize: AppDimensions.cardContentFontSize,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _accountNumber));

                      // Optionally, you can show a snackbar or any other feedback to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Account Number copied to clipboard'),
                        ),
                      );
                    },
                    child: Text(
                      'Copy Account Number',
                      style: GoogleFonts.manrope(
                        fontSize: AppDimensions.helperBtnFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.donationAmount,
              style: GoogleFonts.manrope(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimensions.titleFontSize,
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _donationAmountController,
              decoration: InputDecoration(
                hintText: AppStrings.donationAmountTooltip,
                hintStyle: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.cardContentFontSize,
                  ),
                ),
                filled: true,
                fillColor: AppColors.cardBackgroundColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  child: Text(
                    AppStrings.donatedAmountOne,
                    style: GoogleFonts.manrope(
                      color: AppColors.widgetLightPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.helperBtnFontSize,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  child: Text(
                    AppStrings.donatedAmountTwo,
                    style: GoogleFonts.manrope(
                      color: AppColors.widgetLightPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.helperBtnFontSize,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  child: Text(
                    AppStrings.donatedAmountThree,
                    style: GoogleFonts.manrope(
                      color: AppColors.widgetLightPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.helperBtnFontSize,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  child: Text(
                    AppStrings.donatedAmountFour,
                    style: GoogleFonts.manrope(
                      color: AppColors.widgetLightPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.helperBtnFontSize,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.donorName,
              style: GoogleFonts.manrope(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimensions.titleFontSize,
                ),
              ),
            ),
            Text(
              AppStrings.donorNameSub,
              style: GoogleFonts.manrope(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  fontSize: AppDimensions.subtitleFontSize,
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _donorNameController,
              decoration: InputDecoration(
                hintText: AppStrings.donorNameTooltip,
                hintStyle: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.cardContentFontSize,
                  ),
                ),
                filled: true,
                fillColor: AppColors.cardBackgroundColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: AppColors.cardPrimaryButtonColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () => _recordMyDonationBtnPressed(),
                child: Text(
                  AppStrings.recordMyDonationButtonText,
                  style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: AppDimensions.mainBtnFontSize,
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
