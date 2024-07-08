import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/feautures/home/models/check_out_model.dart';
import 'package:frontend_ams_mobile_official/feautures/home/service/check_out_service.dart';
import 'package:get/get.dart';

class CheckOutRepository extends GetxController {
  final CheckOutService checkOutService;
  CheckOutRepository(this.checkOutService);

  Future<String> checkOut({required CheckOutUserModel checkoutData}) async {
    try {
      final response =
          await checkOutService.checkOut(checkoutData: checkoutData);
      if (response.statusCode == 200) {
        String checkOut = response.data["exitTime"];
        debugPrint('checkOut ${checkOut}');
        return checkOut;
      } else {
        return '';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
