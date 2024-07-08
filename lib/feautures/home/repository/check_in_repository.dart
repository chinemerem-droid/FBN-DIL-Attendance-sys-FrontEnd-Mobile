import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/feautures/home/models/check_in_model.dart';
import 'package:frontend_ams_mobile_official/feautures/home/service/check_in_service.dart';
import 'package:get/get.dart';

class CheckInRepository extends GetxController {
  final CheckInService checkInService;

  RxBool isCheckedIn = false.obs;
  CheckInRepository(this.checkInService);

  Future<String> checkIn({required CheckInUserModel checkinData}) async {
    try {
      final response = await checkInService.checkIn(checkinData: checkinData);
      if (response.statusCode == 200) {
        String checkIn = response.data["entryTime"];
        debugPrint("checkIn ${checkIn}");
        return checkIn;
      } else {
        return "";
      }
    } catch (e) {
      // return null; //
      throw e.toString();
    }
  }
}
