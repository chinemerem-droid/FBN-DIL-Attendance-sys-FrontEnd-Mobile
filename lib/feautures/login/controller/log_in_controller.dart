import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_ams_mobile_official/feautures/login/models/user_model.dart';
import 'package:frontend_ams_mobile_official/feautures/login/repository/Login_repository.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/api_service_locator.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/navigation.dart';
import 'package:frontend_ams_mobile_official/helpers/services/storage_service.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  final StorageService _storage = StorageService();
  final userRepository = getIt.get<LoginRepository>();

  RxBool isProcessing = false.obs;
  RxBool isCheckedIn = false.obs;
  RxBool canSubmit = false.obs;
  RxBool passwordVisibility = true.obs;
  RxBool isFocused = false.obs;
  DateTime now = DateTime.now();

  TextEditingController staff_ID = TextEditingController();
  RxString deviceID = ''.obs;
  RxString deviceModel = ''.obs;

  void togglePasswordVisibility() =>
      passwordVisibility.value = !passwordVisibility.value;

  void signOut() async {
    _storage.deleteValue('token');
    _storage.deleteValue('isLoggedIn');
  }

  void initDependencies() async {
    staff_ID = TextEditingController();
  }

  @override
  void onInit() {
    super.onInit();
    initDeviceInfo();
    initDependencies();
    debugPrint(
        "========================================LogInController initialized");
  }

  Future<void> initDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceID.value = androidInfo.id;
        deviceModel(androidInfo.model);
        debugPrint("Device ID::::::::::::::: ${deviceID.value}");
        debugPrint("Device Model::::::::::::::: ${deviceModel.value}");
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceID.value = iosInfo.identifierForVendor ?? '';
        deviceModel.value = iosInfo.utsname.machine;
      } else {
        throw UnimplementedError('Unsupported platform');
      }
    } catch (e) {
      debugPrint('Failed to get device info: $e');
    }
  }

  Future<void> authenticateUser() async {
    isProcessing.value = true;
    debugPrint("Processing  $isProcessing");

    try {
      var loginData = LoginUserModel(
          deviceID: deviceID.value,
          deviceModel: deviceModel.value,
          staff_ID: staff_ID.text);
      var result = await userRepository.logIn(loginData: loginData);
      if (result.token != '') {
        isProcessing.value = false;
        await _storage.saveString('token', result.token!);
        await _storage.saveString('staff_ID', staff_ID.text);
    

        await _storage.saveBoolean('isLoggedIn', true);
        pushReplacement(page: '/Welcome');
      }
    } catch (e) {
      isProcessing.value = false;
      debugPrint(e.toString());
    }
  }

  //   @override
  // void onClose() {
  //   Get.delete<LogInController>();
  //   super.onClose();
  // }
}
