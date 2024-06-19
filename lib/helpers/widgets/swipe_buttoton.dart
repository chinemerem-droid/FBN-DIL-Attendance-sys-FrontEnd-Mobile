import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/feautures/history/controller/history_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/check_in_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/check_out_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/login/controller/log_in_controller.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/color.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../feautures/history/model/history_model.dart';

class SwipeButton extends StatelessWidget {
  SwipeButton({super.key});

  CheckInController checkInController = Get.find();
  CheckOutController checkOutController = Get.find();
  LogInController logInController = Get.find();
  HistoryController controller = Get.find();

  RxBool isLoading = true.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return logInController.isCheckedIn.value
          ? SlideAction(
              elevation: 0,
              sliderRotate: true,
              innerColor: Colors.white,
              outerColor: primaryColor,
              text: 'Swipe left to check out',
              textStyle: const TextStyle(fontSize: 15, color: Colors.white),
              reversed: true,
              animationDuration: const Duration(milliseconds: 500),
              onSubmit: () async {
                await checkOutController.checkOutUser();
                controller.addAttendanceRecord(AttendanceHistoryModel(
                  staffID: 'Staff001',
                  entryTime: '',
                  exitTime: DateTime.now().toIso8601String(),
                  date: DateTime.now(),
                  month: DateTime.now().month,
                  year: DateTime.now().year,
                ));
              },
            )
          : SlideAction(
              elevation: 0,
              sliderRotate: true,
              innerColor: Colors.white,
              outerColor: primaryColor,
              text: 'Swipe right to check in',
              textStyle: const TextStyle(fontSize: 15, color: Colors.white),
              animationDuration: const Duration(milliseconds: 500),
              onSubmit: () async {
                await checkInController.checkInUser();
                controller.addAttendanceRecord(AttendanceHistoryModel(
                  staffID: 'Staff001',
                  entryTime: DateTime.now().toIso8601String(),
                  exitTime: '',
                  date: DateTime.now(),
                  month: DateTime.now().month,
                  year: DateTime.now().year,
                ));
              },
            );
    });
  }
}
