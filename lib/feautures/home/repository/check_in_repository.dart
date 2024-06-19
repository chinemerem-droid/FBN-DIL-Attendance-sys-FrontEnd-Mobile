import 'package:flutter/widgets.dart';
import 'package:frontend_ams_mobile_official/feautures/home/models/check_in_model.dart';
import 'package:frontend_ams_mobile_official/feautures/home/service/check_in_service.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/app_constants.dart';
import 'package:frontend_ams_mobile_official/helpers/services/storage_service.dart';
import 'package:get/get.dart';

class CheckInRepository extends GetxController {
  final CheckInService checkInService;
  final StorageService _storage = StorageService();

  RxBool isCheckedIn = false.obs;
  CheckInRepository(this.checkInService);

  Future<CheckInUserModel> checkIn(
      {required CheckInUserModel checkinData}) async {
    try {
      final response = await checkInService.checkIn(checkinData: checkinData);
      if (response.statusCode == 200) {
        print(
            '=============================================================== CHECK IN SUCCESSFUL =================================================');
        var user =
            CheckInUserModel.fromJson(response.data['data'] as DynamicMap);
        await _storage.saveString('token', user.token!);
        return user;
      } else {
        debugPrint(
            '=============================================================== CHECK IN UNSUCCESSFUL !!! =================================================');
        return CheckInUserModel.fromJson({});
      }
    } catch (e) {
      // return null; //
      throw e.toString();
    }
  }
}
