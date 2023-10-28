import 'package:devathon_project/Utils/Utils.dart';
import 'package:flutter/material.dart';

import '../resources/Color.dart';

class CustomInputField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final IconButton suffixIcon;
  final String validatorComment;
  const CustomInputField({
    required this.hint,
    required this.controller,
    required this.obscureText,
    required this.suffixIcon,
    required this.validatorComment,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    bool isObsecure = widget.obscureText;
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
      controller: widget.controller,
      obscureText: isObsecure,
      decoration: InputDecoration(
          iconColor: const Color(0xFFC8E3FF),
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 135, 190, 248), width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 135, 190, 248), width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 135, 190, 248), width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          fillColor: const Color(0xFFC8E3FF),
          hintText: widget.hint,
          hintStyle: const TextStyle(
              color: AppColors.silverHintText,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w200),
          suffixIcon: widget.suffixIcon),
    );
  }
}
