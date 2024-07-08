import 'package:dio/dio.dart';
import 'package:frontend_ams_mobile_official/helpers/constants/app_constants.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/dio_client.dart';
import 'package:frontend_ams_mobile_official/helpers/functions/endpoint.dart';

class HistoryService {
  final DioClient dioClient;

  HistoryService({required this.dioClient});

  //getHistory
  Future<Response> getUserHistory({required String staffId}) async {
    try {
      final Response response = await dioClient.makeRequest(
          Endpoints.history, RequestMethod.post,
          data: {'staff_ID': staffId});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
