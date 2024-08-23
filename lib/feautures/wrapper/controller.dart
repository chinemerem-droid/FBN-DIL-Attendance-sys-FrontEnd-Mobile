import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/functions/navigation.dart';
import '../../helpers/services/storage_service.dart';

class WrapperController extends GetxController {
  final StorageService _storage = StorageService();
  // final forgotPasswordRepository = getIt.get<ForgotPasswordRepository>();
  RxString comingFrom = ''.obs;

  String url = Platform.isAndroid
      ? 'https://play.google.com/store/apps/details?id=com.firstbank.lit'
      : 'https://apps.apple.com/ng/app/lit-by-firstbank/id1558685984';

  Future<bool> onWillPop() async {
    return false;
  }

  Future<void> checkExpectedPage() async {
    // await _storage.clearOldData();
    bool _isAuthenticated = await _storage.getBoolean('isLoggedIn');


    final pref = await SharedPreferences.getInstance();
    //bool _isFirstRun = pref.getBool('first_run') ?? true;

    if (!_isAuthenticated) {
      await _storage.clearOldData();
      await pref.clear();
      // pref.setBool('first_run', false);
      pushReplacement(page: '/Register');
    } else if (_isAuthenticated) {
      // even if the user is authenticated he/ she still has to login
      pushReplacement(page: '/Welcome');
    }
  }

  @override
  void onReady() {
    // getComingFrom();
    Future.delayed(const Duration(milliseconds: 1000), () {
      checkExpectedPage();
    });
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<WrapperController>();
    super.onClose();
  }
}
