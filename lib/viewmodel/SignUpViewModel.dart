import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devathon_project/Utils/AuthException.dart';
import 'package:devathon_project/Utils/Utils.dart';
import 'package:devathon_project/view/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpViewModel {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPatient = true;
  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  void changeUserType(bool value) {
    isPatient = value;
  }

  signUpAuth(context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) async {
        await _db.collection('users').doc(value.user!.uid).set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'isPatient': isPatient,
        });
        Utils.toastMessage("Sign Up Successful");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    } catch (e) {
      log(e.toString());
      AuthException.authExceptionToast(e);
    }
  }
}
