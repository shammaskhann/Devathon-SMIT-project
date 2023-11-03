import 'dart:developer';

import 'package:devathon_project/view/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Utils/Utils.dart';

class DoctorViewModel {
  final auth = FirebaseAuth.instance;
  Future<void> bookAppointment(
    String docName,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String id,
    BuildContext context,
  ) async {
    final user = auth.currentUser;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference<Map<String, dynamic>> doctorCollection =
        firestore.collection('doctors');
    final DocumentReference<Map<String, dynamic>> doctorDocument =
        doctorCollection.doc(id);
    final DocumentReference<Map<String, dynamic>> appointmentDocument =
        doctorDocument.collection('appointments').doc();
    await appointmentDocument.set(<String, dynamic>{
      'user': user!.uid,
      'date': selectedDate,
      'time': selectedTime!.format(context),
    }).then((value) async {
      final CollectionReference<Map<String, dynamic>> userCollection =
          firestore.collection('users');
      final DocumentReference<Map<String, dynamic>> userDocument =
          userCollection.doc(user!.uid);
      final DocumentReference<Map<String, dynamic>> userAppointmentDocument =
          userDocument.collection('appointments').doc();
      await userAppointmentDocument.set(<String, dynamic>{
        'DoctorName': docName,
        'date': selectedDate,
        'time': selectedTime!.format(context),
      });
      Utils.toastMessage('Appoinment Sucessfully Booked');
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    });
  }
  checkForDuplicateAppointment(String docName,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String id,
    BuildContext context) async {
  final user = auth.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> doctorCollection =
      firestore.collection('doctors');
  final DocumentReference<Map<String, dynamic>> doctorDocument =
      doctorCollection.doc(id);
  final CollectionReference<Map<String, dynamic>> appointmentCollection =
      doctorDocument.collection('appointments');
  final querySnapshot = await appointmentCollection
      .where('date', isEqualTo: selectedDate)
      .where('time', isEqualTo: selectedTime!.format(context))
      .get();
      log(querySnapshot.docs.toString());
  if (querySnapshot.docs.isEmpty) {
    bookAppointment(docName, selectedDate, selectedTime, id, context);
  } else {
    Utils.toastMessage('Appointment Already Booked');
  }
}
}
