// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:frontend_ams_mobile_official/helpers/constants/app_constants.dart';

class AddUserModel {
  String? message;
  String? token;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? staffID;
  String? labRole;

  AddUserModel({
    this.message,
    this.token,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.staffID,
    this.labRole,
  });

  AddUserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
  }

  DynamicMap toJson() {
    final DynamicMap data = DynamicMap();
    data['fullName'] = fullName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['staffID'] = staffID;
    data['labRole'] = labRole;
    return data;
  }

  @override
  String toString() {
    return 'LoginUserModel(message: $message, token: $token)';
  }
}
