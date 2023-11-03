import 'package:devathon_project/resources/Color.dart';
import 'package:devathon_project/view/DoctorViewScree.dart';
import 'package:devathon_project/viewmodel/CategoryViewModel.dart';
import 'package:flutter/material.dart';

class DoctorCateegoryScreen extends StatefulWidget {
  final String Category;
  const DoctorCateegoryScreen({required this.Category, super.key});

  @override
  State<DoctorCateegoryScreen> createState() => _DoctorCateegoryScreenState();
}

class _DoctorCateegoryScreenState extends State<DoctorCateegoryScreen> {
  CategoryViewModel categoryViewModel = CategoryViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.Category),
        ),
        body: FutureBuilder(
            future: categoryViewModel.getDoctors(widget.Category),
            builder: (context,AsyncSnapshot snapshot) {
            
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if(snapshot.hasData){
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
              }
              else{
                return const Center(child: Text('No Data'));
              }
            }));
  }
}
