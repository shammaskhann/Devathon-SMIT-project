import 'package:devathon_project/resources/Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/Color.dart';

class CustomCategoryButton extends StatelessWidget {
  final String title;
  final String imageLink;
  final onTap;
  const CustomCategoryButton(
      {required this.title,
      required this.imageLink,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onTap();
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppColors.greyText, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: SvgPicture.asset(
                imageLink,
                height: 50,
                width: 50,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(title,
              style: const TextStyle(
                  color: AppColors.greyText,
                  fontSize: 15,
                  fontFamily: 'Poppins')),
        ],
      ),
    );
  }
}
