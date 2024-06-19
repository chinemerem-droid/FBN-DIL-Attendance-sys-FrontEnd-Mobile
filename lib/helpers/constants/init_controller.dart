import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/check_in_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/check_out_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/welcome_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/login/controller/log_in_controller.dart';
import 'package:get/get.dart';

Future<void> init() async {
  debugPrint(
      '==============================================================================STARTING DEBUGGER INITIALIZATION');
  Get.put(() => LogInController());
  Get.put(() => WelcomeController());
  Get.put(() => CheckInController());
  Get.put(() => CheckOutController());
  // Get.put(() => SwipeButtonController());
}
