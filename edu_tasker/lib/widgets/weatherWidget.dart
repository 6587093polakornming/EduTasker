import 'dart:convert';
import 'package:edu_tasker_app/constants/materialDesign.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherAPI {
  static const String _apiKey = '<api key>';
  static const String _city = 'Bangkok';

  static String get apiUrl =>
      'https://api.openweathermap.org/data/2.5/weather?q=$_city&appid=$_apiKey&units=metric';

  static Future<double?> fetchTemperature() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final weatherData = jsonDecode(response.body);
        if (weatherData['main'] != null &&
            weatherData['main']['temp'] != null) {
          final temperature = weatherData['main']['temp'];
          return temperature;
        } else {
          throw Exception('Weather data not found in the response');
        }
      } else {
        throw Exception(
            'Failed to fetch weather data. HTTP status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      return null;
    }
  }
}


Widget buildWeatherReport() {
    return FutureBuilder<double?>(
      future: WeatherAPI.fetchTemperature(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final temperature = snapshot.data!;
          //condition
          IconData iconData;
        if (temperature < 0) {
          iconData = Icons.snowing;
        } else if (temperature < 10) {
          iconData = Icons.ac_unit;
        } else if (temperature < 20) {
          iconData = Icons.cloud;
        } else if (temperature < 30) {
          iconData = Icons.wb_sunny;
        } else {
          iconData = Icons.hot_tub;
        }
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weather Report',
                      style: H5,
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.thermostat, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text(
                          '${temperature.toStringAsFixed(1)}°C',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'City: ${WeatherAPI._city}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16,),
                Icon(
                  iconData,
                  color: Colors.white,
                  size: 80.0,
                ),
                SizedBox(width: 8.0),
              ],
            ),
          );
        }
      },
    );
  }
