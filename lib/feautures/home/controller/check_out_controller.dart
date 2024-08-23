import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/check_in_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/models/check_out_model.dart';
import 'package:frontend_ams_mobile_official/feautures/login/controller/log_in_controller.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/api_service_locator.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/navigation.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/utils.dart';
import 'package:frontend_ams_mobile_official/helpers/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/check_out_repository.dart';

class CheckOutController extends GetxController {
  final StorageService _storage = StorageService();
  final userCheckoutRepository = getIt.get<CheckOutRepository>();

  final LogInController _authController = Get.put(LogInController());

  final CheckInController checkInController = Get.put(CheckInController());

  RxString checkOutTime = "----".obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint(
        "========================================CheckOutController initialized");
  }

  void saveCheckInTime(String time) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('checkInTime', time);
  }

  void setCheckInTime(String time) {
    checkOutTime.value = time;
    saveCheckInTime(time);
  }

  void loadCheckInTime() async {
    final prefs = await SharedPreferences.getInstance();
    String? checkInTimeString = prefs.getString('checkInTime');
    if (checkInTimeString != null) {
      checkOutTime.value = checkInTimeString;
    }
  }

  Future<void> checkOutUser() async {
    String staffId = await _storage.getString('staffID');

    try {
      var checkoutData = CheckOutUserModel(
        staffID: staffId,
      );
      var result =
          await userCheckoutRepository.checkOut(checkoutData: checkoutData);
      if (result.isNotEmpty) {
        _authController.isCheckedIn.value = false;
        await _storage.saveBoolean("isCheckedOut", true);
        setCheckInTime(readableDate(result));
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    // void clearCheckInTime() async {
    //   final prefs = await SharedPreferences.getInstance();
    //   prefs.remove('checkInTime');
    // }
  }

  void signOut() async {
    _storage.deleteValue('token');
    _storage.deleteValue('isLoggedIn');
    pushReplacement(page: 'Login');
  }
}
