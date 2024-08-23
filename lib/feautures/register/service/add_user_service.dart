import 'package:dio/dio.dart';
import 'package:frontend_ams_mobile_official/feautures/register/model/add_user_model.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/app_constants.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/dio_client.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/endpoint.dart';

class AddUserService {
  final DioClient dioClient;

  AddUserService({required this.dioClient});

  Future<Response> addUser({required AddUserModel addUserModelData}) async {
    try {
      final Response response = await dioClient.makeRequest(
          Endpoints.addUser, RequestMethod.post,
          data: addUserModelData);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
