import '../../../helpers/constants/app_constants.dart';

class CheckOutUserModel {
  String? message;
  String? token;
  String? staffID;

  CheckOutUserModel({
    this.message,
    this.token,
    this.staffID,
  });

  CheckOutUserModel.fromJson(DynamicMap json) {
    message = json['message'];
    token = json['token'];
  }

  DynamicMap toJson() {
    final DynamicMap data = DynamicMap();
    data['staffID'] = staffID;
    return data;
  }

  @override
  String toString() {
    return 'LoginUserModel(message: $message, token: $token)';
  }
}
