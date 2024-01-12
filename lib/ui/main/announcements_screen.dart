// Announcement screen. This screen is the right tab in the bottom navigation bar.
// This screen includes a list of announcements fetched from Cloud Firestore
// https://firebase.google.com/docs/firestore

// Stdlib
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// 3rd party
import 'package:google_fonts/google_fonts.dart';
import 'package:inha_masjid/data/announcement.dart';

// Local
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';
import 'package:intl/intl.dart';

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

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  // Variables
  late Stream<QuerySnapshot> _announcementStream;
  late List<Announcement> _announcements;

  // Overrides
  @override
  void initState() {
    super.initState();

    // Set empty values before fetching data
    _announcements = [];

    // Set up announcement stream
    var fs = FirebaseFirestore.instance;
    _announcementStream = fs.collection(FirestorePaths.announcementsCol).snapshots();

    // Parse announcements from stream
    _announcementStream.listen((event) {
      // Load and parse announcements from stream
      List<Announcement> tmp = event.docs.map((e) => Announcement.fromDocument(e)).toList();
      tmp.sort((a, b) => -a.timestamp.compareTo(b.timestamp));

      // Set announcements
      _announcements.clear();
      setState(() {
        _announcements.addAll(tmp);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: BackButton(onPressed: widget.onBackButtonPressed),
        title: Text(
          AppStrings.announcements,
          style: GoogleFonts.manrope(
            fontSize: AppDimensions.screenTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _announcements.length,
        itemBuilder: (context, idx) {
          var announcement = _announcements[idx];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(DateFormat('dd,MM,yyyy').format(announcement.timestamp.toDate()))),
              Card(
                color: AppColors.cardBackgroundColor,
                elevation: AppDimensions.cardElevation,
                child: Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(announcement.title),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          left: 15,
                          right: 15,
                          bottom: 15,
                        ),
                        child: Text(
                          announcement.body,
                          textAlign: TextAlign.start,
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
    );
  }
}
