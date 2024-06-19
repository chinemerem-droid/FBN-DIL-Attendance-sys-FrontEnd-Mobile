import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_ams_mobile_official/feautures/login/controller/log_in_controller.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/api_service_locator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../helpers/services/storage_service.dart';
import '../models/check_in_model.dart';
import '../repository/check_in_repository.dart';

class CheckInController extends GetxController {
  final StorageService _storage = StorageService();
  final userCheckinRepository = getIt.get<CheckInRepository>();
  LogInController logInController = Get.put(LogInController());

  RxString deviceID = ''.obs;
  RxString deviceModel = ''.obs;
  RxBool isLoading = true.obs;
  var timeIn = DateTime.now();

  final LogInController _authController = Get.put(LogInController());

  @override
  void onInit() {
    super.onInit();
    initDeviceInfo();
    debugPrint(
        "========================================Check in Controller initialized");
  }

//================================= GET DEVICE INFO (DEVICE IN AND MODEL) ===========================================

  Future<void> initDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceID.value = androidInfo.id;
        deviceModel(androidInfo.model);
        debugPrint(
            "Device ID for WELCOME CONTROLLER::::::::::::::: ${deviceID.value}");
        debugPrint(
            "Device Model for WELCOME CONTROLLER::::::::::::::: ${deviceModel.value}");
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

//================================= CHECK IN USER  ===========================================

  Future<void> checkInUser() async {
    try {
      Position position = await Geolocator.getCurrentPosition();

      var checkinData = CheckInUserModel(
          deviceID: deviceID.obs.toString(),
          deviceModel: deviceModel.obs.toString(),
          staff_ID: _authController.staff_ID.text,
          Latitude: position.latitude.toString(),
          Longitude: position.longitude.toString());
      debugPrint(
          '===============================================================================================value is  ${logInController.isCheckedIn.isTrue}');

      var result =
          await userCheckinRepository.checkIn(checkinData: checkinData);
      if (result.message != '') {
        logInController.isCheckedIn.value;
        await _storage.saveBoolean("isCheckedIn", true);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
