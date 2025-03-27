import 'dart:io';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../source/remote/api_client.dart';

class HomeProvider with ChangeNotifier {
  final ApiClient _apiClient;

  HomeProvider(this._apiClient);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getLastSevenDaysWeatherHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      final now = DateTime.now();
      final queryParameters = {
        'q': 'London',
        'lang': 'en',
        'dt': DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 6))),
        'end_dt': DateFormat('yyyy-MM-dd').format(now),
      };
      final response = await _apiClient.getWeatherHistory(queryParameters);

      if (response.statusCode == HttpStatus.ok) {
        notifyListeners();
      }
    } on DioException catch (error) {
      debugPrint('Error: ${error.message}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
