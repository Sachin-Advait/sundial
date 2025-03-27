import 'package:flutter/material.dart';
import 'components/temprature_chart_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void onRetry() {}

  @override
  Widget build(BuildContext context) {
    return TemperatureChartView(
      allDaysMaxTemp: 42,
      allDaysMinTemp: 28,
      tempratureData: [
        TempratureModel(
          dateTime: DateTime.parse("2025-03-17"),
          maxTemp: 42,
          minTemp: 32,
        ),
        TempratureModel(
          dateTime: DateTime.parse("2025-03-18"),
          maxTemp: 30,
          minTemp: 29,
        ),
      ],
    );
    //  NoDataAvailableView(onRetry: onRetry);
  }
}
