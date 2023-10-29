import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryViewModel {
  final _db = FirebaseFirestore.instance;
  getDoctors(String speciality) {
    return _db.collection('doctors').orderBy('speciality').get();
  }
}
