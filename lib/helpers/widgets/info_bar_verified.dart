import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/color.dart';

class InfoBarVerified extends StatelessWidget {
  final String text1;
  final String text2;
  InfoBarVerified({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: const Color.fromARGB(255, 211, 209, 209), width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: const TextStyle(
                        color: const Color.fromARGB(255, 29, 29, 29)),
                  ),
                  Text(
                    text2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
