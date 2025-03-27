import 'dart:io';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../source/remote/api_client.dart';
import '../../models/weather_history_details_response.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeProvider with ChangeNotifier {
  final ApiClient _apiClient;

  HomeProvider(this._apiClient);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<DateAndTempratureDetails> _dateTempDetails = [];
  List<DateAndTempratureDetails> get dateTempDetails => _dateTempDetails;

  Future<void> getLastSevenDaysWeatherHistory() async {
    EasyLoading.show(status: 'loading...');
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

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        _dateTempDetails =
            WeatherHistoryDetailsResponse.fromJson(
              response.data!,
            ).forecast?.dayAndTempratureDetails ??
            [];
        _isLoading = false;
        notifyListeners();
      }
    } on DioException catch (error) {
      debugPrint('Error: ${error.message}');
    } finally {
      EasyLoading.dismiss();
      _isLoading = false;
      notifyListeners();
    }
  }
}
