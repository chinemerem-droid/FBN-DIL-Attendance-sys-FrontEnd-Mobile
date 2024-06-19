import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ams_mobile_official/feautures/history/controller/history_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/check_in_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/check_out_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/controller/location_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/home/repository/check_in_repository.dart';
import 'package:frontend_ams_mobile_official/feautures/home/repository/check_out_repository.dart';
import 'package:frontend_ams_mobile_official/feautures/home/service/check_in_service.dart';
import 'package:frontend_ams_mobile_official/feautures/home/service/check_out_service.dart';
import 'package:frontend_ams_mobile_official/feautures/login/controller/log_in_controller.dart';
import 'package:frontend_ams_mobile_official/feautures/login/repository/Login_repository.dart';
import 'package:frontend_ams_mobile_official/feautures/login/service/login_service.dart';
import 'package:get_it/get_it.dart';
import 'dio_client.dart';

GetIt getIt = GetIt.instance;

Future<void> apiServiceLocator() async {
  try {
    getIt.registerSingleton(Dio());
    getIt.registerSingleton(DioClient(getIt<Dio>()));

//============================================================================================

    // Login
    getIt.registerSingleton(LoginService(dioClient: getIt<DioClient>()));
    debugPrint('LOGIN SERVICE registered');

    getIt.registerSingleton(LoginRepository(getIt.get<LoginService>()));
    debugPrint('LOGIN REPOSITORY registered');

    getIt.registerSingleton(LogInController());
    debugPrint('LOGIN CONTROLLER registered');

//============================================================================================
    // chekin
    getIt.registerSingleton(CheckInService(dioClient: getIt<DioClient>()));
    debugPrint('CHECK IN SERVICE registered');

    getIt.registerSingleton(CheckInRepository(getIt.get<CheckInService>()));
    debugPrint('CHECK IN REPOSITORY registered');

    getIt.registerSingleton(CheckInController());
    debugPrint('CHECK IN CONTROLLER registered');

//============================================================================================

    // chekout
    getIt.registerSingleton(CheckOutService(dioClient: getIt<DioClient>()));
    debugPrint('CHECK OUT SERVICE registered');

    getIt.registerSingleton(CheckOutRepository(getIt.get<CheckOutService>()));
    debugPrint('CHECK OUT REPOSITORY registered');

    getIt.registerSingleton(CheckOutController());
    debugPrint('CHECK OUT CONTROLLEER registered');

    //============================================================================================

    getIt.registerSingleton(LocationController());
    debugPrint('LOCATION CONTROLLER registered');

    //============================================================================================

    getIt.registerSingleton(HistoryController());
    debugPrint('HISTORY CONTROLLER registered');
  } catch (e) {
    debugPrint('Error during registration: $e');
  }

  // // Reset password
  // getIt.registerSingleton(ResetPasswordService(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(
  //     ResetPasswordRepository(getIt.get<ResetPasswordService>()));
  // getIt.registerSingleton(ResetPasswordController());

  // // Create account
  // getIt.registerSingleton(SignUpService(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(SignUpRepository(getIt.get<SignUpService>()));
  // getIt.registerSingleton(SignUpController());

  // // OTP
  // getIt.registerSingleton(OtpService(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(OtpRepository(getIt.get<OtpService>()));
  // getIt.registerSingleton(OtpController());

  // // Notification
  // getIt.registerSingleton(NotificationService(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(
  //     NotificationRepository(getIt.get<NotificationService>()));
  // getIt.registerSingleton(NotificationController());

  // // Profile
  // getIt.registerSingleton(ProfileService(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton(ProfileRepository(getIt.get<ProfileService>()));
  // getIt.registerSingleton(ProfileController());
}
