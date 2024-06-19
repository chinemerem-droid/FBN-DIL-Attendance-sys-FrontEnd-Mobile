import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants/app_constants.dart';
import '../services/storage_service.dart';
 
class DioClient {
  // dio instance
  final Dio _dio;
  final StorageService _storage = StorageService();

  // base url
  String baseUrl = dotenv.env['PROD_BASE_URL']!;
  // String baseUrl = dotenv.env['DEV_BASE_URL']!;

  // injecting dio instance
  DioClient(this._dio) {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(milliseconds: 45000)
      ..options.receiveTimeout = const Duration(milliseconds: 45000)
      ..options.contentType = 'application/json'
      ..options.headers['Content-Type'] = 'application/json'
      ..options.responseType = ResponseType.json
      ..options.followRedirects = false
      ..options.validateStatus = (status) {
        return status! < 500;
      }
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
  }

  Map<String, dynamic> get requiredParams {
    final params = <String, dynamic>{};
    return params;
  }

  Future<Response<dynamic>> makeRequest(
    String uri,
    RequestMethod method, {
    Map<String, dynamic>? queryParameters,
    bool reqToken = false,
    bool reqUserId = false,
    dynamic data,
    Options? options,
    FormData? formData,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    String? token = await _storage.getString('token');
    // String? userId = await _storage.getString('id');

    final params = queryParameters ?? requiredParams;
    var headers = <String, dynamic>{};

    if (reqToken && reqUserId) {
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
        // 'id': '$userId',
      };
    } else if (reqToken) {
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      };
    } else {
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
    }
    options = Options(headers: headers);

    return switch (method) {
      RequestMethod.post => await _dio.post(
          uri,
          queryParameters: params,
          data: data,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
      RequestMethod.put => await _dio.put(
          uri,
          queryParameters: params,
          data: data,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
      RequestMethod.patch => await _dio.patch(
          uri,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        ),
      RequestMethod.get => await _dio.get(
          uri,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        ),
      RequestMethod.delete => await _dio.delete(
          uri,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
        ),
    };
  }
}
