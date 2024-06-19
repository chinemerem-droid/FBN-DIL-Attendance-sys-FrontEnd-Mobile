import 'package:flutter/widgets.dart';
import 'package:frontend_ams_mobile_official/feautures/login/models/user_model.dart';
import 'package:frontend_ams_mobile_official/feautures/login/service/login_service.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/app_constants.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/navigation.dart';
import 'package:frontend_ams_mobile_official/helpers/services/storage_service.dart';
import 'package:get/get.dart';

class LoginRepository extends GetxController {
  final LoginService loginService;

  final StorageService _storage = StorageService();
  // LogInController logInController = Get.put(LogInController());
  //final logInController = getIt.get<LogInController>();
  // LogInController logInController = Get.find();
  LoginRepository(this.loginService);

  Future<LoginUserModel> logIn({required LoginUserModel loginData}) async {
    try {
      final response = await loginService.logIn(loginData: loginData);
      if (response.statusCode == 200) {
        // logInController.isProcessing.isFalse;
        debugPrint(
            '=============================================================== LOGIN SUCCESSFUL, ENTERING THE  WELCOME PAGE =================================================');
        pushReplacement(page: '/Welcome');
        var user = LoginUserModel.fromJson(response.data['data'] as DynamicMap);
        await _storage.saveString('token', user.token!);

        return user;
      } else {
        return LoginUserModel.fromJson({});
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
