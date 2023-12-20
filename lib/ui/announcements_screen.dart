// Announcement screen. This screen is the right tab in the bottom navigation bar.
// This screen includes a list of announcements fetched from Cloud Firestore
// https://firebase.google.com/docs/firestore

// Stdlib
import 'package:flutter/material.dart';

// 3rd party
import 'package:google_fonts/google_fonts.dart';

// Local
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';

/// TODO write documentation
class AnnouncementsScreen extends StatefulWidget {
  // Variables
  final VoidCallback onBackButtonPressed;

  // Constructor
  const AnnouncementsScreen({
    super.key,
    required this.onBackButtonPressed,
  });

  // Overrides
  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

/// TODO write documentation
class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: BackButton(onPressed: widget.onBackButtonPressed),
        title: Text(
          AppStrings.announcementsScreenTitle,
          style: GoogleFonts.manrope(
            fontSize: AppDimensions.screenTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: (AppStrings.items.length),
          itemBuilder: (_, index) {
            final item = AppStrings.items[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 8,
                    right: 0,
                    bottom: 0,
                  ),
                  child: Text(
                    item['date'],
                    style: const TextStyle(
                      fontSize: AppDimensions.announcementsPageDateFontSize,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    color: AppColors.cardBackgroundColor,
                    elevation: AppDimensions.cardElevation,
                    child: ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      shape: Border.all(color: Colors.transparent),
                      title: Text(item['title']),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 16,
                            right: 16,
                            bottom: 16,
                          ),
                          child: Text(
                            item['content'],
                            style: TextStyle(color: AppColors.cardTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
