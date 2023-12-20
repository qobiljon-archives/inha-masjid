import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: BackButton(
          onPressed: () {
            // When clicked it should return home_screen
          },
        ),
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: Card(
                    color: AppColors.cardBackgroundColor,
                    elevation: AppDimensions.cardElevation,
                    child: ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      shape: Border.all(color: Colors.transparent),
                      title: Text(
                        item['title'],
                      ),
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
                            style: TextStyle(
                              color: AppColors.cardTextColor,
                            ),
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
