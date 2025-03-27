import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../models/temprature_details_model.dart';

class TemperatureChartView extends StatelessWidget {
  const TemperatureChartView({
    super.key,
    required this.tempratureData,
    required this.allDaysMaxTemp,
    required this.allDaysMinTemp,
  });

  final List<TempratureDetailsModel> tempratureData;
  final double allDaysMaxTemp, allDaysMinTemp;

  List<FlSpot> _getMaxTempSpots() {
    return List.generate(
      tempratureData.length,
      (i) => FlSpot(i.toDouble(), tempratureData[i].maxTemp),
    );
  }

  List<FlSpot> _getMinTempSpots() {
    return List.generate(
      tempratureData.length,
      (i) => FlSpot(i.toDouble(), tempratureData[i].minTemp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Weekly Temperature Graph"),
        backgroundColor: Colors.white,
        elevation: 2,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Max & Min Temperatures (°C)",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Graph Card
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 20, 15),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 5,
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget:
                                (value, meta) => Text(
                                  "${value.toInt()}°",
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  DateFormat.E().format(
                                    tempratureData[value.toInt()].dateTime,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            },
                            interval: 1,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: tempratureData.length.toDouble() - 1,
                      minY:
                          allDaysMinTemp % 2 == 0
                              ? allDaysMinTemp - 4
                              : allDaysMinTemp - 5,
                      maxY:
                          allDaysMaxTemp % 2 == 0
                              ? allDaysMaxTemp + 4
                              : allDaysMaxTemp + 5,

                      // Line Touch Data Tooltip.
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((spot) {
                              bool isMaxTemp = spot.barIndex == 0;
                              return LineTooltipItem(
                                "${isMaxTemp ? "Max" : "Min"}: ${spot.y}°C",
                                const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),

                      lineBarsData: [
                        // Max Temperature Line
                        LineChartBarData(
                          spots: _getMaxTempSpots(),
                          isCurved: true,
                          color: Colors.redAccent,
                          barWidth: 4,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                Colors.redAccent.withAlpha(50),
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          dotData: FlDotData(show: true),
                        ),

                        // Min Temperature Line
                        LineChartBarData(
                          spots: _getMinTempSpots(),
                          isCurved: true,
                          color: Colors.blueAccent,
                          barWidth: 4,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                Colors.blueAccent.withAlpha(50),
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          dotData: FlDotData(show: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
