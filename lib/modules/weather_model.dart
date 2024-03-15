class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  // final int? humidity;
  // final double? windSpeed;
  // final String? windDirection;
  // final double? visibility;
  // final DateTime? sunrise;
  // final DateTime? sunset;
  Weather(
    {
      required this.cityName,
      required this.temperature,
      required this.mainCondition,
      // this.humidity,
      // this.windSpeed,
      // this.windDirection,
      // this.visibility,
      // this.sunrise,
      // this.sunset,


    }
  );
 factory Weather.fromJson(Map<String, dynamic> json){
  return Weather(
    cityName: json['name'], 
    temperature: json['main']['temp'].toDouble(),
    mainCondition: json['weather'][0]['main'],
      // humidity: json['main']['humidity'],
      // windSpeed: json['wind']['speed'].toDouble(), // Ensure conversion to double
      // windDirection: _getWindDirection(json['wind']['deg']),
      // visibility: json['visibility'] != null ? json['visibility'] / 1000.0 : null,
      // sunrise: json['sys']['sunrise'] != null ? DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000) : null,
      // sunset: json['sys']['sunset'] != null ? DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000) : null,
    );
 }
  // static String _getWindDirection(double? degree) {
  //   if (degree == null) return '';
  //   final directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
  //   final index = ((degree + 22.5) / 45).floor() % 8;
  //   return directions[index];
  // }

  // String get sunriseFormatted {
  //   return sunrise != null ? '${sunrise!.hour}:${sunrise!.minute}' : '';
  // }

  // String get sunsetFormatted {
  //   return sunset != null ? '${sunset!.hour}:${sunset!.minute}' : '';
  }

 
