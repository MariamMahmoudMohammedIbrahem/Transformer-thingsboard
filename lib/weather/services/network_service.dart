

import 'package:http/http.dart' as http;

import '../../thingsboard/commons.dart';

class NetworkData {
  NetworkData(this.url);
  final String url;
  Future getData() async {
    if (kDebugMode) {
      print('get data in network service');
    }
    http.Response response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print('response => $response');
      print('response body => ${response.body}');
    }
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      if (kDebugMode) {
        print('response.statusCode => ${response.statusCode}');
      }
    }
  }
}