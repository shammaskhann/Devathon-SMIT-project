import 'package:cloud_firestore/cloud_firestore.dart';

class HomeViewModel {
  final _db = FirebaseFirestore.instance;
  Future getBestRatedDoctor() {
    return _db
        .collection('doctors')
        .orderBy('rating', descending: true)
        .limit(4)
        .get();
  }
}
