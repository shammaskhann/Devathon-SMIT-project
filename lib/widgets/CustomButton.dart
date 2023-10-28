import 'dart:developer';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final onTap;
  final String title;
  final bool loading;
  const CustomButton(
      {required this.onTap,
      required this.title,
      required this.loading,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xFFB28CFF),
              borderRadius: BorderRadius.circular(21),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Center(
            child: (!loading)
                ? Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700),
                  )
                : const CircularProgressIndicator(),
          ),
        ));
  }
}
