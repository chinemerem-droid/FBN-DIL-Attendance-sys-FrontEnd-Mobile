// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:frontend_ams_mobile_official/helpers/constants/app_constants.dart';

class LoginUserModel {
  String? message;
  String? token;
  String? staffID;
  String? deviceID;
  String? deviceModel;

  LoginUserModel(
      {this.message,
      this.token,
      this.staffID,
      this.deviceID,
      this.deviceModel});

  LoginUserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
  }

  DynamicMap toJson() {
    final DynamicMap data = DynamicMap();
    data['staffID'] = staffID;
    data['deviceID'] = deviceID;
    data['deviceModel'] = deviceModel;
    return data;
  }

  @override
  String toString() {
    return 'LoginUserModel(message: $message, token: $token)';
  }
}
