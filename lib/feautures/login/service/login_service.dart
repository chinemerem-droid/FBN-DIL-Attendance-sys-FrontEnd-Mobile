import 'package:dio/dio.dart';
import 'package:frontend_ams_mobile_official/feautures/login/models/user_model.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/app_constants.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/dio_client.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/endpoint.dart';
// import 'package:get/get.dart';

class LoginService {
  final DioClient dioClient;

  LoginService({required this.dioClient});

  //login
  Future<Response> logIn(
      {required LoginUserModel loginData}) async {
    try {
      final Response response = await dioClient.
          makeRequest(Endpoints.login, RequestMethod.post, data: loginData.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
