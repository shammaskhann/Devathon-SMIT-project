import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeViewModel {
  final _db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Future getBestRatedDoctor() {
    return _db
        .collection('doctors')
        .orderBy('rating', descending: true)
        .limit(4)
        .get();
  }
  Future<String> getName(){
    final user = auth.currentUser;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference<Map<String, dynamic>> userCollection =
        firestore.collection('users');
    final DocumentReference<Map<String, dynamic>> userDocument =
        userCollection.doc(user!.uid);
    return userDocument.get().then((value) => value.data()!['name']);
  }
  Future<String> getEmail(){
    final user = auth.currentUser;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference<Map<String, dynamic>> userCollection =
        firestore.collection('users');
    final DocumentReference<Map<String, dynamic>> userDocument =
        userCollection.doc(user!.uid);
    return userDocument.get().then((value) => value.data()!['email']);
  }
}
