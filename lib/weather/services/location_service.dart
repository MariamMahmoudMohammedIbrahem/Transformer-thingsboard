/*
import 'package:geolocator/geolocator.dart';
class Location {
  late double latitude;
  late double longitude;
  late int status;

  Future<void> getCurrentLocation() async {
    print('hello world 3');
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('hello world 31');

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}*/
