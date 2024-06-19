import 'package:flutter/widgets.dart';
import 'package:frontend_ams_mobile_official/feautures/home/models/check_out_model.dart';
import 'package:frontend_ams_mobile_official/feautures/home/service/check_out_service.dart';
import 'package:frontend_ams_mobile_official/feautures/login/controller/log_in_controller.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/app_constants.dart';
import 'package:frontend_ams_mobile_official/helpers/services/storage_service.dart';
import 'package:get/get.dart';

class CheckOutRepository extends GetxController {
  final CheckOutService checkOutService;
  final StorageService _storage = StorageService();
  CheckOutRepository(this.checkOutService);

  LogInController logInController = Get.find();

  Future<CheckOutUserModel> checkOut(
      {required CheckOutUserModel checkoutData}) async {
    try {
      final response =
          await checkOutService.checkOut(checkoutData: checkoutData);
      if (response.statusCode == 200) {
        logInController.isCheckedIn.value;
        debugPrint(
            '=============================================================== CHECK OUT SUCCESSFUL =================================================');
        var user =
            CheckOutUserModel.fromJson(response.data['data'] as DynamicMap);
        await _storage.saveString('token', user.token!);
        return user;
      } else {
        return CheckOutUserModel.fromJson({});
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
