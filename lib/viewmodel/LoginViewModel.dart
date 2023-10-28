import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../Utils/AuthException.dart';
import '../Utils/Utils.dart';
import '../view/HomeScreen.dart';

class LoginViewModel {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  loginAuth(context) async {
    loading = true;
    await auth
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((value) {
      Utils.toastMessage("Login Successful");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }).catchError((e) {
      AuthException.authExceptionToast(e.code);
      Utils.toastMessage(e.toString());
    });
  }
}
