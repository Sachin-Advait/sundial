import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_provider.dart';
import 'components/temprature_chart_view.dart';
import '../../models/temprature_details_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void onRetry() {}

  @override
  Widget build(BuildContext context) {
    return context.watch<HomeProvider>().isLoading
        ? const Center(child: CircularProgressIndicator())
        : TemperatureChartView(
          allDaysMaxTemp: 42,
          allDaysMinTemp: 28,
          tempratureData: [
            TempratureDetailsModel(
              dateTime: DateTime.parse("2025-03-17"),
              maxTemp: 42,
              minTemp: 32,
            ),
            TempratureDetailsModel(
              dateTime: DateTime.parse("2025-03-18"),
              maxTemp: 30,
              minTemp: 29,
            ),
          ],
        );
    //  NoDataAvailableView(onRetry: onRetry);
  }
}
