import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/weather_model.dart';
import 'package:flutter_application_1/services/weather_service.dart';
import 'package:lottie/lottie.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api key
  final _weatherService = WeatherService('18cc388d058085d1ddf52b1fa9e6f061');
  Weather? _weather; 


  _fetchWeather() async{

    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }


    catch(e){
      print(e);
    }
  }
  String getWeatherAnimation(String? mainCondition) {
  if (mainCondition == null) return 'assets/sunny.json';

  switch (mainCondition.toLowerCase()){
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return 'assets/cloudy.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/rainy.json';
    case 'thunderstrom':
      return 'assets/thunder.json';
    case 'clear':
      return 'assets/sunny.json';
    default:
      return 'assets/sunny.json'; // Fallback if no match is found
  }
}


@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchWeather();
  }




  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_weather?.cityName ?? "Konjam Wait Pannunga Boss..."),
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
          Text(
            _weather == null 
              ? "Loading..." 
              : '${_weather!.temperature.round()}°C'
          ),
          Text(_weather?.mainCondition ?? ""),
        ],
      ),
    ),
  );
}
}