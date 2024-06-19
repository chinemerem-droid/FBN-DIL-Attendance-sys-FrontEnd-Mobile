import 'package:dio/dio.dart';
import 'package:frontend_ams_mobile_official/feautures/home/models/check_in_model.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/app_constants.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/dio_client.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/endpoint.dart';
 
class CheckInService {
  final DioClient dioClient;

  CheckInService({required this.dioClient});

  //login
  Future<Response> checkIn({required CheckInUserModel checkinData}) async {
    try {
      final Response response = await dioClient.makeRequest(
          Endpoints.checkin, RequestMethod.post,
          data: checkinData.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  } 
}
