import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devathon_project/resources/Image.dart';
import 'package:devathon_project/view/AssignmetnScreen.dart';
import 'package:devathon_project/view/CategoryDoctorScreen.dart';
import 'package:devathon_project/view/DoctorViewScree.dart';
import 'package:devathon_project/widgets/CustomCategoryButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../resources/Color.dart';
import '../viewmodel/HomeViewModel.dart';
import 'LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;
  final HomeViewModel homeViewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: FutureBuilder(
                  future: homeViewModel.getName(), 
                  builder:((context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Shimmer(
                        gradient: LinearGradient(
                          colors: [Colors.grey, Colors.grey[200]!],
                        ),
                        child: Container(
                          height: 20,
                          width: 100,
                          color: Colors.grey,
                        ),
                      );
                    }
                    if(snapshot.hasData){
                      return Text(snapshot.data.toString());
                    }
                    else{
                      return const Text('No Name');
                    }
                  })),
                accountEmail: FutureBuilder(
                  future: homeViewModel.getEmail(), 
                  builder:((context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Shimmer(
                        gradient: LinearGradient(
                          colors: [Colors.grey, Colors.grey[200]!],
                        ),
                        child: Container(
                          height: 20,
                          width: 100,
                          color: Colors.grey,
                        ),
                      );
                    }
                    if(snapshot.hasData){
                      return Text(snapshot.data.toString());
                    }
                    else{
                      return const Text('No Email');
                    }
                  })),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Schedule Appointment'),
                onTap: () {
                  // Do something when the user taps on the Settings item
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AssignmentScreen()));
                },
              ),
              ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    // Do something when the user taps on the Logout item
                    auth.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  }),
            ],
          ),
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20, right: 30),
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(35)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage('assets/Images/doctor1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins'),
                        ),
                        Text('Let\'s find\nyour top doctor!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins'),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Doctor's Inn",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Categories',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      )),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CustomCategoryButton(
                          title: "All",
                          imageLink: AppImages.allCatIcon,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DoctorCateegoryScreen(
                                            Category: "ALL")));
                          },
                        ),
                        CustomCategoryButton(
                          title: "Cardiology",
                          imageLink: AppImages.cardioIcon,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DoctorCateegoryScreen(
                                            Category: "Cardiology")));
                          },
                        ),
                        CustomCategoryButton(
                          title: "Medicine",
                          imageLink: AppImages.medicineIcon,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DoctorCateegoryScreen(
                                            Category: "Medicine")));
                          },
                        ),
                        CustomCategoryButton(
                          title: "General",
                          imageLink: AppImages.generalIcon,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DoctorCateegoryScreen(
                                            Category: "General Dentist")));
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.395,
                    child: FutureBuilder(
                        future: homeViewModel.getBestRatedDoctor(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            log(snapshot.data.toString());
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.size,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DoctorViewScreen(
                                                  name: snapshot
                                                      .data!.docs[index]
                                                      .get('name'),
                                                  imgLink: snapshot
                                                      .data!.docs[index]
                                                      .get('avatar'),
                                                  speciality: snapshot
                                                      .data!.docs[index]
                                                      .get('speciality'),
                                                  exp: snapshot
                                                      .data!.docs[index]
                                                      .get('experience'),
                                                  rating: snapshot
                                                      .data!.docs[index]
                                                      .get('rating'),
                                                  about: snapshot
                                                      .data!.docs[index]
                                                      .get('about'),
                                                  noOfPatient: snapshot
                                                      .data!.docs[index]
                                                      .get('patients'),
                                                  review: snapshot
                                                      .data!.docs[index]
                                                      .get('reviews'),
                                                  id: snapshot.data!.docs[index]
                                                      .get('id'),
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      height: 100,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: AppColors.greyText,
                                            width: 2),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Image.asset(snapshot
                                                      .data.docs[index]
                                                      .get('avatar')),
                                                ),
                                                //rating
                                                Row(
                                                  children: [
                                                    const Icon(Icons.star_half,
                                                        color:
                                                            Colors.greenAccent),
                                                    Text(
                                                        snapshot
                                                            .data.docs[index]
                                                            .get('rating'),
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .greenAccent))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  snapshot.data.docs[index]
                                                      .get('name'),
                                                  style: const TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Poppins')),
                                              Row(
                                                children: [
                                                  Text(
                                                      snapshot.data.docs[index]
                                                          .get('speciality'),
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .greyText,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Poppins')),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      snapshot.data.docs[index]
                                                          .get('location'),
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .greyText,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Poppins'))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text('No Doctors Availble'),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
