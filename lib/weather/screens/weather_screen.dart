// import 'package:flutter/material.dart';
//
// import '../constants/constants.dart';
// import '../services/weather_service.dart';
//
// class Weather extends StatefulWidget {
//   const Weather({super.key});
//
//   @override
//   State<Weather> createState() => WeatherState();
// }
//
// class WeatherState extends State<Weather> {
//   int temperature = 0;
//   String condition = '';
//   int humidity = 0;
//   String country = '';
//   String city = '';
//   String weatherIcon = '';
//   String tempIcon = '';
//   WeatherModel weatherModel = WeatherModel();
//
//   @override
//   void initState() {
//     super.initState();
//     getLocationData();
//   }
//
//   getLocationData() async {
//     var weatherData = await weatherModel.getLocationWeather();
//     setState(() {
//       condition = weatherData['weather'][0]['main'];
//       humidity = weatherData['main']['humidity'];
//       country = weatherData['sys']['country'];
//       city = weatherData['name'];
//       double temp = weatherData['main']['temp'];
//       temperature = temp.toInt();
//     });
//   }
//
//   void updateUI(dynamic weather) {
//     setState(() {
//       if (weather == null) {
//         temperature = 0;
//         weatherIcon = 'Error';
//         tempIcon = 'Unable to get weather data';
//         city = '';
//         return;
//       }
//       var condition = weather['weather'][0]['id'];
//       weatherIcon = weatherModel.getWeatherIcon(condition);
//       double temp = weather['main']['temp'];
//       temperature = temp.toInt();
//       tempIcon = weatherModel.getMessage(temperature);
//
//       city = weather['name'];
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink.shade900,
//         title: const Text('Weather App',style: TextStyle(color: Colors.white),),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(20),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 padding: const EdgeInsets.all(5.0),
//                 child: TextField(
//                   style: const TextStyle(color: Colors.black),
//                   decoration: textFieldDecoration,
//                   onChanged: (value) {
//                     city = value;
//                   },
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   TextButton(
//                     onPressed: () async {
//                       var weatherData = await weatherModel.getCityWeather(city);
//                       updateUI(weatherData);
//                     },
//                     child: Text(
//                       'Get Weather',
//                       style: kButtonTextStyle,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () async {
//                       var weatherData = await weatherModel.getLocationWeather();
//                       updateUI(weatherData);
//                     },
//                     icon: Icon(
//                       Icons.near_me,
//                       color: Colors.pink.shade900,
//                       size: 50.0,
//                     ),),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: Row(
//                   children: <Widget>[
//                     Text(
//                       '$temperature°  ',
//                       style: kTempTextStyle,
//                     ),
//                     Text(
//                       '🤷‍',
//                       style: kConditionTextStyle,
//                     ),
//                   ],
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 15.0),
//                   child: Text(
//                     '$tempIcon in $city',
//                     style: kMessageTextStyle,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }