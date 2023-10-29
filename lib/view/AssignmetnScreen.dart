// import 'package:devathon_project/viewmodel/AssigmentViewModel.dart';
// import 'package:flutter/material.dart';

// class AssignmentScreen extends StatefulWidget {
//   const AssignmentScreen({super.key});

//   @override
//   State<AssignmentScreen> createState() => _AssignmentScreenState();
// }

// class _AssignmentScreenState extends State<AssignmentScreen> {
//   AssignmentViewModel assignmentViewModel = AssignmentViewModel();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             centerTitle: true, title: const Text('Scheduled Appointment')),
//         body: FutureBuilder(
//             future: assignmentViewModel.getAllAppointment(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//               } else {
//                 return Center(
//                   child: Text("NO APPOINTMENT SCHEDULED"),
//                 );
//               }
//             }));
//   }
// }
