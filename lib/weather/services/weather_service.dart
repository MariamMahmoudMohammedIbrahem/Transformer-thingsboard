/*

import 'network_service.dart';
import 'location_service.dart';
const weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = '710004193dbd480fa95113d5185aabdc';
*/
/*
class WeatherModel {

  Future<dynamic> getLocationWeather() async {
    /// await for methods that return future
    print('hello world 2');
    Location location = Location();
    await location.getCurrentLocation();
    print('hello world 21');
    NetworkData networkHelper = NetworkData(
        '$weatherApiUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');
    print('here inside getLocationWeather');
    var weatherData = await networkHelper.getData();
    print('weatherData => $weatherData');
    return weatherData;
  }

}*//*


class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$weatherApiUrl?q=$cityName&appid=$apiKey&units=metric';
    NetworkData networkHelper = NetworkData(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    /// Get location
    /// await for methods that return future
    Location location = Location();
    await location.getCurrentLocation();

    /// Get location data
    NetworkData networkHelper = NetworkData(
        '$weatherApiUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  /// add appropriete icon to page  according to response from API
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
}*/
