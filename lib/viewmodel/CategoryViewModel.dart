import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryViewModel {
  final _db = FirebaseFirestore.instance;
  getDoctors(String speciality) {
    log("speciality: $speciality");
    if(speciality == "ALL"){
      return _db.collection('doctors').get();
    }
    else if(speciality == 'General Dentist'){
      return _db
          .collection('doctors')
          .where('speciality', isEqualTo: 'Dentist')
          .get();
    }
    return _db
        .collection('doctors')
        .where('speciality', isEqualTo: speciality)
        .get();
  }
}
