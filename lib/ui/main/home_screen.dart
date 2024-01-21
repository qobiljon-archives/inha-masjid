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
import 'package:inha_masjid/data/donation_record.dart';
import 'package:inha_masjid/ui/main/about_masjid_screen.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/extensions.dart';
import 'package:inha_masjid/utils/strings.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
  late Stream<DocumentSnapshot> _monthlyRentStream;
  late List<DonationRecord> _donationRecords;
  late int _totalAmount;
  late int _raisedAmount;

  // Lifecycle
  @override
  void initState() {
    super.initState();

    // Set empty values before fetching data
    _donationRecords = [];
    _totalAmount = 0;
    _raisedAmount = 0;

    // Set up donation stream
    var fs = FirebaseFirestore.instance;
    _donationStream = fs.collection(FirestorePaths.donationsCol).snapshots();
    _monthlyRentStream = fs.doc(FirestorePaths.monthlyRentDoc).snapshots();

    // Parse donation records from stream
    _donationStream.listen((event) {
      // Load and parse donation records from stream
      List<DonationRecord> tmp =
          event.docs.map((e) => DonationRecord.fromDocument(e)).toList();
      tmp.sort((a, b) => -a.timestamp.compareTo(b.timestamp));

      // Set donation records
      _donationRecords.clear();
      setState(() {
        _donationRecords.addAll(tmp);
      });

      // Calculate raised amount
      // Get start and end DateTimes for current month for filtering donation records
      DateTime now = DateTime.now();
      Timestamp start = Timestamp.fromDate(DateTime(now.year, now.month)
          .subtract(const Duration(microseconds: 1)));
      Timestamp end = Timestamp.fromDate(DateTime(now.year, now.month + 1));
      int tmpRaisedAmount = 0;
      for (var d in _donationRecords) {
        if (d.timestamp.compareTo(start) == 1 &&
            d.timestamp.compareTo(end) == -1) {
          tmpRaisedAmount += d.amount;
        }
      }
      setState(() {
        _raisedAmount = tmpRaisedAmount;
      });
    });
    _monthlyRentStream.listen((event) {
      int amount = event.get('amount');
      setState(() {
        _totalAmount = amount;
      });
    });
  }

  // Functions
  void _onOpenAdminPageBtnPressed() async {
    await Navigator.pushNamed(context, '/admin_login');
  }

  void _donateBtnPressed() async {
    await Navigator.pushNamed(context, '/donate');
  }

  void _openAboutMasjidOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const AboutMasjid(),
    );
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
        actions: [
          IconButton(
            onPressed: _openAboutMasjidOverlay,
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Admin panel
            Card(
              color: AppColors.cardBackgroundColor,
              elevation: AppDimensions.cardElevation,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(
                  children: [
                    // Card title and close button
                    Row(
                      children: [
                        // Question prompt: Are you admin?
                        Text(
                          AppStrings.areYouAdmin,
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontSize: AppDimensions.cardTitleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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

                    // Raised and total amounts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Raised amount
                        Text(
                          AppStrings.raisedAmount(_raisedAmount,
                                  addCurrency: true)
                              .capitalize(),
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontSize: AppDimensions.cardContentSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // Total amount
                        Text(
                          AppStrings.requiredAmount(_totalAmount,
                              addCurrency: true),
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontSize: AppDimensions.cardContentSmallSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Progress Bar
                    LinearProgressIndicator(
                      value:
                          _totalAmount == 0 ? 1 : _raisedAmount / _totalAmount,
                      backgroundColor: AppColors.white,
                      color: AppColors.cardPrimaryButtonColor,
                      minHeight: 16,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    const SizedBox(height: 20),

                    Column(
                      children: [
                        AnimatedTextKit(
                          pause: const Duration(milliseconds: 3000),
                          repeatForever: true,
                          animatedTexts: [
                            TyperAnimatedText(
                              '"Charity does not decrease wealth"',
                              textStyle: GoogleFonts.nanumMyeongjo(
                                textStyle: const TextStyle(
                                  fontSize: AppDimensions.cardTitleFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              speed: const Duration(
                                  milliseconds:
                                      100), // Adjust the speed as needed
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        const Text('  - Sahih Muslim 2588'),
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(
                                Uri.parse('https://sunnah.com/muslim:2588'));
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
                      icon: const Icon(Icons.mosque_rounded,
                          color: AppColors.white),
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
                    Column(children: [
                      for (var d in _donationRecords)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Text(
                                '• ${d.donorName} donated ${d.amount.commaSeparated()}원',
                                style: GoogleFonts.manrope(
                                  textStyle: const TextStyle(
                                    fontSize: AppDimensions
                                        .transactionHistoryNameFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                ' (${DateFormat('dd,MM,yyyy').format(d.timestamp.toDate())})',
                                // Use 'dd,MM,yyyy' for day, month, year format
                                style: GoogleFonts.manrope(
                                  textStyle: const TextStyle(
                                    fontSize: AppDimensions
                                        .transactionHistoryNameFontSize,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ]),
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
