import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  Announcement({
    required this.timestamp,
    required this.title,
    required this.body,
  });

  static Announcement fromDocument(DocumentSnapshot doc) {
    return Announcement(
      timestamp: doc['timestamp'],
      title: doc['title'],
      body: doc['body'],
    );
  }

  Timestamp timestamp;
  String title;
  String body;
}
