import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier{
  final String apiKey = 'cfb4280ac688ebec047a724413da2b10';
  Map<String,dynamic>? weatherData;
  String? errorMessage;
  bool isLoading = false;

  Future<void> fetchWeather(String location)async{
    if (location.trim().isEmpty) {
      errorMessage="please enter a location";
      weatherData=null;
      notifyListeners();
    }

    isLoading=true;
    errorMessage=null;
    weatherData=null;
    notifyListeners();

    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=${Uri.encodeComponent(location)}&appid=$apiKey&uit=metric"
    );

    try {
      final response = await http.get(url);
      if (response.statusCode==200) {
        weatherData = json.decode(response.body);
        errorMessage=null;
        notifyListeners();
      }else if (response.statusCode==404) {
        errorMessage="location not found";
        weatherData=null;
      }else{
        errorMessage="error to fetch eather data";
        weatherData=null;
      }
    }catch(e){
      errorMessage="Error : $e";
      print(errorMessage);
      weatherData =null;
    }
    isLoading=false;
    notifyListeners();
  }

}