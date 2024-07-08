import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/color.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SwipeButtonNonActive extends StatelessWidget {
  const SwipeButtonNonActive({super.key});

  @override
  Widget build(BuildContext context) {
    return const SlideAction(
      elevation: 0,
      innerColor: Colors.white,
      outerColor: primaryColor,
      text: 'Swipe right to check in',
      textStyle: TextStyle(fontSize: 15, color: Colors.white),
      animationDuration: Duration(milliseconds: 500),
      enabled: false,
    );
  }
}
