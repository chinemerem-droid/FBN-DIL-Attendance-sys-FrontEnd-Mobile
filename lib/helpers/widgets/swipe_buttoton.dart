import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/check_in_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/check_out_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/login/controller/log_in_controller.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/color.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SwipeButton extends StatelessWidget {
  SwipeButton({Key? key}) : super(key: key);

  final CheckInController checkInController = Get.find();
  final CheckOutController checkOutController = Get.find();
  final LogInController logInController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isCheckedIn = logInController.isCheckedIn.value;

      return SlideAction(
        elevation: 0,
        sliderRotate: true,
        innerColor: isCheckedIn ? primaryColor : Colors.white,
        submittedIcon: CircularProgressIndicator(
          color: isCheckedIn ? primaryColor : Colors.white,
        ),
        outerColor: isCheckedIn ? Colors.white : primaryColor,
        reversed: isCheckedIn,
        animationDuration: const Duration(milliseconds: 500),
        onSubmit: () async {
          // DateTime now = DateTime.now();

          if (isCheckedIn) {
            await checkOutController.checkOutUser();
          } else {
            await checkInController.checkInUser();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              width: 1,
              color: isCheckedIn ? primaryColor : Colors.transparent,
            ),
            color: Colors.transparent,
          ),
          child: Center(
            child: Text(
              isCheckedIn
                  ? 'Swipe left to check out'
                  : 'Swipe right to check in',
              style: TextStyle(
                fontSize: 14.sp,
                color: isCheckedIn ? primaryColor : Colors.white,
              ),
            ),
          ),
        ),
      );
    });
  }
}
