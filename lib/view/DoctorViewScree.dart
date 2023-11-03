import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Utils/Utils.dart';
import '../resources/Color.dart';
import '../viewmodel/DoctorViewModel.dart';
import '../widgets/CustomButton.dart';

class DoctorViewScreen extends StatefulWidget {
  final String name;
  final String imgLink;
  final String speciality;
  final String exp;
  final String rating;
  final String review;
  final String noOfPatient;
  final String about;
  final String id;
  const DoctorViewScreen(
      {required this.name,
      required this.imgLink,
      required this.speciality,
      required this.exp,
      required this.rating,
      required this.about,
      required this.noOfPatient,
      required this.review,
      required this.id,
      super.key});

  @override
  State<DoctorViewScreen> createState() => _DoctorViewScreenState();
}

class _DoctorViewScreenState extends State<DoctorViewScreen> {
  DoctorViewModel doctorViewModel = DoctorViewModel();
  var loading = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Appointment'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      widget.imgLink,
                    ))),
          ),
        ),
        Text(widget.name,
            style: const TextStyle(
                color: AppColors.black,
                fontSize: 25,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600)),
        Text(widget.speciality,
            style: const TextStyle(
                color: Color.fromARGB(255, 116, 120, 131),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400)),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(35)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(23)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${widget.noOfPatient}+",
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 35,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700)),
                        const Text("Patients",
                            style: TextStyle(
                                color: AppColors.greyText,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(23)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${widget.exp}+",
                            style: const TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 35,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700)),
                        const Text("Exp Year",
                            style: TextStyle(
                                color: AppColors.greyText,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(23)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${widget.review}+",
                            style: const TextStyle(
                                color: Color(0xFFFF9A9A),
                                fontSize: 35,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700)),
                        const Text("Reviews",
                            style: TextStyle(
                                color: AppColors.greyText,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About Doctor',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
                textAlign: TextAlign.left,
              ),
              Text(widget.about,
                  style: const TextStyle(color: Color(0xFF8A96BC))),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Select a date:',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            _showDatePicker(context);
                          },
                          child: Text(
                            selectedDate == null
                                ? 'Select a date'
                                : DateFormat.yMMMd().format(selectedDate!),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Select a time:',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            _showTimePicker(context);
                          },
                          child: Text(
                            selectedTime == null
                                ? 'Select a time'
                                : selectedTime!.format(context),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              CustomButton(
                onTap: () async{
                  if (selectedDate != null && selectedTime != null) {
                    setState(() {
                      loading = true;
                    });
                    await doctorViewModel.checkForDuplicateAppointment(widget.name, selectedDate, selectedTime, widget.id, context).then((value) {
                      setState(() {
                        loading = false;
                      });
                    });
                  } else {
                    Utils.toastMessage('Select Date & Time');
                  }
                },
                title: " Book an Appointment",
                loading: loading,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 11, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }
}
