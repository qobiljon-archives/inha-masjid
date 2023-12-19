// Announcements screen.

// Stdlib
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';

/// TODO write documentation for announcements screen.
class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

/// TODO write documentation for announcements screen state.
class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          AppStrings.announcementsScreenTitle,
          style: GoogleFonts.manrope(
            fontSize: AppDimensions.screenTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: Text('TBD: announcements screen'),
      ),
    );
  }
}
