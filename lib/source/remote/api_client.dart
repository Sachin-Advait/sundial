import 'package:dio/dio.dart';

abstract interface class ApiClient {
  // Auth API Clients
  Future<Response<Map<String, dynamic>>> getWeatherHistory(
    Map<String, String> queryParameters,
  );
}
