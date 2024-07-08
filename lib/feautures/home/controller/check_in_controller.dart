import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_ams_mobile_official/feautures/login/controller/log_in_controller.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/api_service_locator.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  RxString checkInTime = "----".obs;
  DateTime now = DateTime.now();

  // final LogInController _authController = Get.put(LogInController());

  @override
  void onInit() {
    super.onInit();
    loadCheckInTime();
    initDeviceInfo();
    debugPrint(
        "========================================Check in Controller initialized");

    debugPrint(
        '-====================================================CHECK IN TIME VALUE ${checkInTime.value} ');
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
      String staffId = await _storage.getString('staff_ID');
      // String stID = await _storage.getString('staff_ID') ?? "";

      debugPrint("******** STAFFID $staffId");

      if (staffId.isEmpty) {
        Get.snackbar('Error', 'Staff ID not authecticated',
            snackPosition: SnackPosition.TOP);

        return;
      }

      var checkinData = CheckInUserModel(
        deviceID: deviceID.obs.toString(),
        deviceModel: deviceModel.obs.toString(),
        staff_ID: staffId,
        Latitude: position.latitude.toString(),
        Longitude: position.longitude.toString(),
      );
      var result =
          await userCheckinRepository.checkIn(checkinData: checkinData);

      if (result.isNotEmpty) {
        logInController.isCheckedIn.value = true;
        await _storage.saveBoolean("isCheckedIn", true);
        setCheckInTime(readableDate(result));
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void saveCheckInTime(String time) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('checkInTime', time);
  }

  void setCheckInTime(String time) {
    checkInTime.value = time;
    // saveCheckInTime(time);
  }

  void loadCheckInTime() async {
    final prefs = await SharedPreferences.getInstance();
    String? checkInTimeString = prefs.getString('checkInTime');
    if (checkInTimeString != null) {
      checkInTime.value = checkInTimeString;
    }
  }

  void clearCheckInTime() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('checkInTime');
  }
}
