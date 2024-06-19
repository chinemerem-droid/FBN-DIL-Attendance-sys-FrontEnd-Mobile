import 'package:dio/dio.dart';
import 'package:frontend_ams_mobile_official/feautures/home/models/check_out_model.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/app_constants.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/dio_client.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/endpoint.dart';

class CheckOutService {
  final DioClient dioClient;

  CheckOutService({required this.dioClient});

  //chekout
  Future<Response> checkOut({required CheckOutUserModel checkoutData}) async {
    try {
      final Response response = await dioClient.makeRequest(
          Endpoints.checkout, RequestMethod.put,
          data: checkoutData.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
