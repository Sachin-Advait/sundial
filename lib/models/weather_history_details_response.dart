class WeatherHistoryDetailsResponse {
  final Forecast? forecast;

  WeatherHistoryDetailsResponse({this.forecast});

  factory WeatherHistoryDetailsResponse.fromJson(Map<String, dynamic> json) =>
      WeatherHistoryDetailsResponse(
        forecast:
            json["forecast"] == null
                ? null
                : Forecast.fromJson(json["forecast"]),
      );
}

class Forecast {
  final List<DateAndTempratureDetails>? dayAndTempratureDetails;

  Forecast({this.dayAndTempratureDetails});

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    dayAndTempratureDetails:
        json["forecastday"] == null
            ? []
            : List<DateAndTempratureDetails>.from(
              json["forecastday"]!.map(
                (x) => DateAndTempratureDetails.fromJson(x),
              ),
            ),
  );
}

class DateAndTempratureDetails {
  final DateTime date;
  final double maxTemp, minTemp;

  DateAndTempratureDetails({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
  });

  factory DateAndTempratureDetails.fromJson(Map<String, dynamic> json) =>
      DateAndTempratureDetails(
        date: DateTime.parse(json["date"]),
        maxTemp: json["day"]["maxtemp_c"]?.toDouble(),
        minTemp: json["day"]["mintemp_c"]?.toDouble(),
      );
}
