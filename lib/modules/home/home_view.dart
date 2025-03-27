import 'home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/temprature_chart_view.dart';
import 'components/no_data_available_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().getLastSevenDaysWeatherHistory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<HomeProvider>().isLoading
        ? SizedBox()
        : context.watch<HomeProvider>().dateTempDetails.isEmpty
        ? NoDataAvailableView(
          onRetry:
              () async =>
                  context.read<HomeProvider>().getLastSevenDaysWeatherHistory(),
        )
        : TemperatureChartView(
          dateTempratureDetails: context.watch<HomeProvider>().dateTempDetails,
        );
  }
}
