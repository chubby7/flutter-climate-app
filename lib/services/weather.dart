import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '7d13909f17cfc7c38d53d8c4e14d8fcd';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async{
    NetworkHelper networkHelper = NetworkHelper(
      '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric'
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

Future<dynamic> getLocationWeather() async{
  Location locate = Location();
  await locate.getCurrentLocation();

  NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?lat=${locate.latitude}&lon=${locate.longitude}&appid=$apiKey&units=metric');

  var weatherData = await networkHelper.getData();
  return weatherData;
}


  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
