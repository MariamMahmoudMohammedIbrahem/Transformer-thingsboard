// import 'package:geolocator/geolocator.dart';
// class LocationClass {
//   late double latitude;
//   late double longitide;
//   String apiKey = 'your API key';
//   late int status;
//
//   /// async and await are used for time consuming tasks
//   /// Get your current loatitude and longitude
//   /// Location accuracy depends on the type of app high,low ,
//   /// high accuracy also result in more power consumed
//   Future<void> getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//
//       latitude = position.latitude;
//       longitide = position.longitude;
//       print('lon $longitide, lat $latitude');
//     } catch (e) {
//       print(e);
//     }
//   }
// }