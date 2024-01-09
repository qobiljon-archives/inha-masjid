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
import 'package:inha_masjid/ui/donate/record_donation_screen.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/extensions.dart';
import 'package:inha_masjid/utils/strings.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
    var fs = FirebaseFirestore.instance;
    _donationStream = fs.collection(FirestorePaths.donationsCol).snapshots();
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
          AppStrings.home,
          style: GoogleFonts.manrope(
            fontSize: AppDimensions.screenTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Admin panel
            Card(
              color: AppColors.cardBackgroundColor,
              elevation: AppDimensions.cardElevation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Card title and close button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Question prompt: Are you admin?
                        const Text(AppStrings.areYouAdmin),

                        // Close button
                        IconButton(
                          onPressed: _onCloseAdminCardBtnPressed,
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),

                    // Admin login button
                    TextButton(
                      onPressed: _onOpenAdminPageBtnPressed,
                      child: Text(AppStrings.goToAdmin.toUpperCase()),
                    ),
                  ],
                ),
              ),
            ),

            // Donate
            Card(
              elevation: AppDimensions.cardElevation,
              color: AppColors.cardBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current progress title (donation collection progress)
                    // Row is used for making the Card full width (couldn't find other way)
                    Row(
                      children: [
                        Text(
                          AppStrings.currentProgress,
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontSize: AppDimensions.cardTitleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Raised and total amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Raised amount
                        Text(
                          AppStrings.raisedAmount(12345, addCurrency: true).capitalize(),
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontSize: AppDimensions.cardContentSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // Total amount
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .doc(FirestorePaths.monthlyRentDoc)
                              .snapshots(),
                          builder: (context, snapshot) {
                            // Loading
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            // Error
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            // Empty (no data)
                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return Container();
                            }

                            // Extracting data from snapshot
                            var doc = snapshot.data!;
                            int amount = doc['amount'];

                            // Returning the widget
                            return Text(
                              AppStrings.requiredAmount(amount, addCurrency: true),
                              style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                  fontSize: AppDimensions.cardContentSmallSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Progress Bar
                    LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: AppColors.white,
                      color: AppColors.cardPrimaryButtonColor,
                      minHeight: 16,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Text(
                            '"Charity does not decrease wealth"',
                            style: GoogleFonts.nanumMyeongjo(
                              textStyle: const TextStyle(
                                fontSize: AppDimensions.cardTitleFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('  - Sahih Muslim 2588'),
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse('https://sunnah.com/muslim:2588'));
                          },
                          child: const Text(
                            ' (sunnah.com)',
                            style: TextStyle(
                              color: AppColors.cardPrimaryButtonColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Donate button (opens record donation screen)
                    ElevatedButton.icon(
                      onPressed: _donateBtnPressed,
                      icon: const Icon(Icons.mosque_rounded, color: AppColors.white),
                      label: Text(
                        AppStrings.donate.toUpperCase(),
                        style: const TextStyle(color: AppColors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cardPrimaryButtonColor,
                        minimumSize: const Size(
                          double.infinity,
                          AppDimensions.donateButtonHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Activity feed (donations)
            Card(
              elevation: AppDimensions.cardElevation,
              color: AppColors.cardBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Activity feed title
                    Row(
                      children: [
                        Text(
                          AppStrings.activityFeed,
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontSize: AppDimensions.cardTitleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Activity feed list
                    StreamBuilder<QuerySnapshot>(
                      stream: _donationStream,
                      builder: (context, snapshot) {
                        // Loading
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        // Error
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        // Empty (no data)
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Text(AppStrings.noDonations);
                        }

                        // Donation docs list
                        var docs = snapshot.data!.docs;

                        // Make children list
                        var children = <Widget>[];
                        for (var doc in docs) {
                          // Donation details
                          Timestamp ts = doc['timestamp'];
                          String donorName = doc['donorName'];
                          int amount = doc['amount'];

                          // Adding the widgets
                          children.add(Row(
                            children: [
                              Text(
                                '• $donorName donated ${amount.commaSeparated()}원',
                                style: GoogleFonts.manrope(
                                  textStyle: const TextStyle(
                                    fontSize: AppDimensions.transactionHistoryNameFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                ' (${DateFormat.yMMMMd().format(ts.toDate())})',
                                style: GoogleFonts.manrope(
                                  textStyle: const TextStyle(
                                    fontSize: AppDimensions.transactionHistoryNameFontSize,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ));
                        }

                        // Adding the widgets
                        return Column(children: children);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
