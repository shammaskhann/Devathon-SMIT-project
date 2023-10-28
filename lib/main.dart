import 'package:devathon_project/firebase_options.dart';
import 'package:devathon_project/view/HomeScreen.dart';
import 'package:devathon_project/view/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC8E3FF)),
          useMaterial3: true,
        ),
        home: (auth.currentUser == null)
            ? const LoginScreen()
            : const HomeScreen());
  }
}
//Theme for light and dark mode 
