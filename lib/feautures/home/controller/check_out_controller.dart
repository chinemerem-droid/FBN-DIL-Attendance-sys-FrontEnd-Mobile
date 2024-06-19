import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/check_in_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/models/check_out_model.dart';
import 'package:frontend_ams_mobile_official/feautures/login/controller/log_in_controller.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/api_service_locator.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/navigation.dart';
import 'package:frontend_ams_mobile_official/helpers/services/storage_service.dart';
import 'package:get/get.dart';
import '../repository/check_out_repository.dart';

class CheckOutController extends GetxController {
  final StorageService _storage = StorageService();
  final userCheckoutRepository = getIt.get<CheckOutRepository>();

  final LogInController _authController = Get.put(LogInController());

  final CheckInController checkInController = Get.put(CheckInController());

  var checkOutTime = ''.obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint(
        "========================================CheckOutController initialized");
  }

  Future<void> checkOutUser() async {
    try {
      var checkoutData = CheckOutUserModel(
        staff_ID: _authController.staff_ID.text,
      );
      var result =
          await userCheckoutRepository.checkOut(checkoutData: checkoutData);
      if (result.message != '') {
        debugPrint(
            '===============================================================================================value is  ${_authController.isCheckedIn.isTrue}');

        _authController.isCheckedIn.isTrue;
        await _storage.saveBoolean("isCheckedOut", true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void signOut() async {
    _storage.deleteValue('token');
    _storage.deleteValue('isLoggedIn');
    pushReplacement(page: 'Login');
  }
}
