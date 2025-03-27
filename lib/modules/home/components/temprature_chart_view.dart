import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../models/weather_history_details_response.dart';

class TemperatureChartView extends StatelessWidget {
  const TemperatureChartView({super.key, required this.dateTempratureDetails});

  final List<DateAndTempratureDetails> dateTempratureDetails;

  @override
  Widget build(BuildContext context) {
    double allDaysMaxTemp = double.negativeInfinity;
    double allDaysMinTemp = double.infinity;

    List<FlSpot> maxTempSpots = [];
    List<FlSpot> minTempSpots = [];

    for (int i = 0; i < dateTempratureDetails.length; i++) {
      if (dateTempratureDetails[i].maxTemp > allDaysMaxTemp) {
        allDaysMaxTemp = dateTempratureDetails[i].maxTemp;
      }

      if (dateTempratureDetails[i].minTemp < allDaysMinTemp) {
        allDaysMinTemp = dateTempratureDetails[i].minTemp;
      }

      maxTempSpots.add(FlSpot(i.toDouble(), dateTempratureDetails[i].maxTemp));
      minTempSpots.add(FlSpot(i.toDouble(), dateTempratureDetails[i].minTemp));
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Weekly Temperature Graph"),
        backgroundColor: Colors.white,
        elevation: 2,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Max & Min Temperatures (°C)",
                style: GoogleFonts.bonaNova(
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
                                    dateTempratureDetails[value.toInt()].date,
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
                      maxX: dateTempratureDetails.length.toDouble() - 1,
                      minY: double.parse(
                        allDaysMinTemp % 2 == 0
                            ? (allDaysMinTemp - 2).toStringAsFixed(0)
                            : (allDaysMinTemp - 3).toStringAsFixed(0),
                      ),
                      maxY: double.parse(
                        allDaysMaxTemp % 2 == 0
                            ? (allDaysMaxTemp + 2).toStringAsFixed(0)
                            : (allDaysMaxTemp + 3).toStringAsFixed(0),
                      ),

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
                          spots: maxTempSpots,
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
                          spots: minTempSpots,
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
