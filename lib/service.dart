import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';

class WeatherService {
  static Future<WeatherModel> apiWeatherResponse() async {
    String city = 'Hyderabad';
    // String apikey = dotenv.env['WEATHER_API_KEY']!;
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=8a0862dbdd2595f5f7a6d9e5d78f296a&units=metric',
    );
    try {
      final data = await http.get(url);
      if (data.statusCode == 200) {
        final r = jsonDecode(data.body);
        print(r);
        return WeatherModel(
          temp: List.generate(r['cnt'], (i) => r['list'][i]['main']['temp']),
          weathertype: List.generate(
            r['cnt'],
            (i) => r['list'][i]['weather'][0]['main'],
          ),
          pressure: r['list'][0]['main']['pressure'],
          humidity: r['list'][0]['main']['humidity'],
          windspeed: r['list'][0]['wind']['speed'],
          time: List.generate(r['cnt'], (i) => r['list'][i]['dt_txt']),
        );
      } else {
        throw 'Failed to load data';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Widget getWeatherCondition(String weathertype) {
    if (weathertype == "Rain") {
      print('rain');
      return Lottie.network('assets/lottie/rain.json'); // rain animation
    } else if (weathertype.contains('Clear')) {
      return Lottie.asset('assets/lottie/sunny.json'); //sunny animation
    } else {
      return Lottie.asset('assets/lottie/clouds.json'); //cloudy animation
    }
  }
}
