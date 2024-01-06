// Home screen. This is the main screen of the application shown both to
// regular users and admins. Regular users can see the donation progress
// bar, recent donations list, and other information about the masjid.
// Admin users can also click on the admin login button to go to admin
// panel, and regular users can click on the `x` button to hide the admin
// login button.

// Stdlib
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inha_masjid/ui/record_donation_screen.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';

/// Home screen shown to both regular and admin users.
class HomeScreen extends StatefulWidget {
  // Variables
  final VoidCallback onBackButtonPressed;

  // Constructor
  const HomeScreen({
    super.key,
    required this.onBackButtonPressed,
  });

  // Overrides
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// Home screen state that shows the varying donation progress bar, and
/// recent donations list. Admin users can also click on the admin login
/// button to go to admin panel, and regular users can click on the `x`
/// button to hide the admin login button.
class _HomeScreenState extends State<HomeScreen> {
  // Variables
  late Stream<QuerySnapshot> _donationStream;

  // Lifecycle
  @override
  void initState() {
    super.initState();

    // Donation stream
    _donationStream =
        FirebaseFirestore.instance.collection('/donations').snapshots();
  }

  // Functions
  void _onCloseAdminCardBtnPressed() {
    // TODO finish this
  }

  void _onOpenAdminPageBtnPressed() async {
    await Navigator.pushNamed(context, '/admin_login');
  }

  void _donateBtnPressed() async {
    await Navigator.pushNamed(context, '/donate');
  }

  // Override
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
          // Admin login button
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
                        AppStrings.areYouAdmin,
                        style: TextStyle(
                          fontSize: AppDimensions.homeScreenCardFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: _onCloseAdminCardBtnPressed,
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _onOpenAdminPageBtnPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 82.6,
                        vertical: 17,
                      ), // Adjust the padding values as needed
                      textStyle: const TextStyle(
                        fontSize: AppDimensions.homeScreenCardFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: AppColors.cardButtonBackgroundColor,
                    ),
                    child: Text(
                      AppStrings.goToAdmin,
                      style: GoogleFonts.manrope(
                        textStyle: const TextStyle(
                          fontSize: AppDimensions.homeScreenCardFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Donation progress and log (history)
          Expanded(
            child: ListView(
              children: [
                // Donation progress bar and record donation button
                Card(
                  margin: const EdgeInsets.all(15),
                  elevation: AppDimensions.cardElevation,
                  color: AppColors.cardBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Required amount
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            AppStrings.masjidNeededAmount,
                            style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                fontSize: AppDimensions.homeScreenCardFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .doc("/masjidConfigs/monthlyFee")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }

                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }

                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return const Text('Document does not exist');
                                }

                                // Extracting data from snapshot
                                var amount = snapshot.data!['amount'];
                                var currency = snapshot.data!['currency'];

                                // Widget for displaying amount and currency
                                Widget amountAndCurrencyWidget() {
                                  return Row(
                                    children: [
                                      Text(
                                        '$amount',
                                        style: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppDimensions
                                                .requiredTotalAmount,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '$currency',
                                        style: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppDimensions
                                                .requiredTotalAmount,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                // Returning the widget
                                return amountAndCurrencyWidget();
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Text(
                          '0 KRW raised ',
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),

                        // Progress Bar
                        LinearProgressIndicator(
                          value: 0.5,
                          backgroundColor: AppColors.white,
                          color: AppColors.cardButtonBackgroundColor,
                          minHeight: 16,
                          borderRadius: BorderRadius.circular(20),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: _donateBtnPressed,
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 17,
                                  ),
                                  backgroundColor:
                                      AppColors.cardButtonBackgroundColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.monetization_on,
                                      color: AppColors.white,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      AppStrings.donate,
                                      style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppDimensions
                                              .homeScreenCardFontSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Donation records
                Card(
                  margin: const EdgeInsets.all(15),
                  elevation: AppDimensions.cardElevation,
                  color: AppColors.cardBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Text(
                            AppStrings.activityFeed,
                            style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                fontSize: AppDimensions.homeScreenCardFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _donationStream,
                            builder: (context, snapshot) {
                              // Loading
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              // Error
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              // Empty (no data)
                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Container();
                              }

                              // Data exists
                              var donationDocs = snapshot.data!.docs;
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, idx) {
                                  var donation = donationDocs[idx];
                                  var donorName = donation['donorName'];
                                  var donationAmount =
                                      donation['donationAmount'];
                                  print('$donorName donated $donationAmount');
                                  return Text(
                                    '$donorName donated $donationAmount',
                                    style: GoogleFonts.manrope(
                                      textStyle: const TextStyle(
                                        fontSize: AppDimensions
                                            .transactionHistoryNameFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
