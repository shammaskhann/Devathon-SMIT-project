import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:devathon_project/viewmodel/AssigmentViewModel.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  AssignmentViewModel assignmentViewModel = AssignmentViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true, title: const Text('Scheduled Appointment')),
        body: FutureBuilder(
            future: assignmentViewModel.getAllAppointment(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(snapshot.data.docs[index]['DoctorName']),
                          subtitle: Text(formatTimestamp(
                              snapshot.data.docs[index]['date'])),
                          trailing: Text(
                              snapshot.data.docs[index]['time'].toString()),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text("NO APPOINTMENT SCHEDULED"),
                );
              }
            }));
  }

  String formatTimestamp(Timestamp timestamp) {
    // Convert the Firebase timestamp to a DateTime
    DateTime date = timestamp.toDate();

    // Define the date format
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    // Format the date as a string in the desired format
    String formattedDate = dateFormat.format(date);

    return formattedDate;
  }
}
