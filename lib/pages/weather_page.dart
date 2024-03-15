import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/modules/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherServices("0cf3bbbd354bce27415027279f14b1d7");
  Weather? _weather;
  bool _isDay = true; // Assume it's daytime by default

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
      _checkIsDay();
    } catch (e) {
      print(e);
    }
  }

  // Check if it's day or night based on current time
  void _checkIsDay() {
    final now = DateTime.now();
    final hour = now.hour;
    // Assuming nighttime is from 6 PM to 6 AM
    setState(() {
      _isDay = !(hour >= 18 || hour < 6);
    });
  }

  String getWeatherAnimation(String? mainCondition) {
    if (!_isDay) {
      // It's night, so show moon animation
      return 'assets/moon.json';
    }

    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.transparent, // Make Scaffold's background transparent
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 0, 0, 0), // Darkest color (black) in the top right corner
            Colors.white, // Lightest color (white) in the bottom left corner
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Location icon and city name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: Colors.grey),
                SizedBox(width: 5),
                Text(
                  _weather?.cityName ?? "loading city..",
                  style: TextStyle(
                    fontSize: 45, // Increased font size
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Weather animation
            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition),
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            // Temperature
            Text(
              "${_weather?.temperature.round()}°",
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            SizedBox(height: 10),
            // Weather condition
            Text(
              _weather?.mainCondition ?? "",
              style: TextStyle(
                fontSize: 25,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
