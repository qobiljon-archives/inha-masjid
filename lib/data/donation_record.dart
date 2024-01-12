import 'package:cloud_firestore/cloud_firestore.dart';

class DonationRecord {
  DonationRecord({
    required this.timestamp,
    required this.donorName,
    required this.amount,
  });

  static DonationRecord fromDocument(DocumentSnapshot doc) {
    return DonationRecord(
      timestamp: doc['timestamp'],
      donorName: doc['donorName'],
      amount: doc['amount'],
    );
  }

  Timestamp timestamp;
  String donorName;
  int amount;
}
