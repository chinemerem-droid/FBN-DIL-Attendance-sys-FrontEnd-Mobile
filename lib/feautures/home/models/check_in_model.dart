import '../../../helpers/constants/app_constants.dart';

class CheckInUserModel {
  String? message;
  String? token;
  String? staff_ID;
  String? deviceID;
  String? deviceModel;
  String? Latitude;
  String? Longitude;

    CheckInUserModel({
    this.message,
    this.token,
    this.staff_ID,
    this.deviceID,
    this.deviceModel,
    this.Latitude,
    this.Longitude
  });

  CheckInUserModel.fromJson(DynamicMap json) {
    message = json['message'];
    token = json['token'];
  }

  DynamicMap toJson() {
    final DynamicMap data =   DynamicMap();
    data['staff_ID'] =  staff_ID;
    data['deviceID'] =  deviceID;
    data['deviceModel'] =  deviceModel;
    data['Latitude'] =  Latitude;
    data['Longitude'] =  Longitude;
    return data;
  }

  // @override
  // String toString() {
  //   return 'LoginUserModel(message: $message, token: $token)';
  // }

}
