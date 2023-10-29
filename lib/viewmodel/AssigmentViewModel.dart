import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AssignmentViewModel {
  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  getAllAppointment() {
    final user = auth.currentUser;
    return _db
        .collection('users')
        .doc(user!.uid)
        .collection('appointments')
        .get();
  }
}
