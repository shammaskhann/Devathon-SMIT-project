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
            builder: (context, snapshot) {
              return Container();
            }));
  }
}
