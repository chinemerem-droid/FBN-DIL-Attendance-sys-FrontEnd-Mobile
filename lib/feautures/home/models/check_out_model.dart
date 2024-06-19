import '../../../helpers/constants/app_constants.dart';

class CheckOutUserModel {
  String? message;
  String? token;
  String? staff_ID;

   CheckOutUserModel({
    this.message,
    this.token,
    this.staff_ID,
   });

  CheckOutUserModel.fromJson(DynamicMap json) {
    message = json['message'];
    token = json['token'];
  }

  DynamicMap toJson() {
    final DynamicMap data =   DynamicMap();
    data['staff_ID'] = staff_ID;
     return data;
  }

  @override
  String toString() {
    return 'LoginUserModel(message: $message, token: $token)';
  }
}
