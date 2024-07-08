import 'package:flutter/material.dart';

import '../constants/color.dart';

class InfoWaringBar extends StatelessWidget {
  final String text1;
  final String text2;
  const InfoWaringBar({super.key, required this.text1, required this.text2});

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
                border: Border.all(color: Colors.red, width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: const TextStyle(
                        color:   Color.fromARGB(255, 29, 29, 29)),
                  ),
                  Text(
                    text2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
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
