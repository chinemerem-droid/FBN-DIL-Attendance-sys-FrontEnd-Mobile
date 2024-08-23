import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/feautures/register/model/add_user_model.dart';
import 'package:frontend_ams_mobile_official/feautures/register/service/add_user_service.dart';
import 'package:get/get.dart';

class AddUserRepository extends GetxController {
  final AddUserService addUserService;

  AddUserRepository(this.addUserService);

  Future<AddUserModel> addUser({required AddUserModel addUserData}) async {
    try {
      final response =
          await addUserService.addUser(addUserModelData: addUserData);
      if (response.statusCode == 200) {
        debugPrint(
            '============================================================== USER ADDED SUCCESSFULLY  =================================================');
        var user = AddUserModel.fromJson(response.data as Map<String, dynamic>);
        return user;
      } else {
        return AddUserModel.fromJson({});
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
      throw e.toString();
    }
  }
}
