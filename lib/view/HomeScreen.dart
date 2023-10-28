import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text('Person Name'),
                accountEmail: Text(''),
                currentAccountPicture: CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  // Do something when the user taps on the Settings item
                },
              ),
              ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    // Do something when the user taps on the Logout item
                    auth.signOut();
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFFB28CFF),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            //OpenDrawer
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          icon: const Icon(Icons.menu)),
                      Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                            image: AssetImage('assets/Images/doctor1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        )));
  }
}
