import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkData {
  NetworkData(this.url);
  final String url;
  Future getData() async {
    print('get data in network service');
    http.Response response = await http.get(Uri.parse(url));
    print('response => $response');
    print('response body => ${response.body}');
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('response.statusCode => ${response.statusCode}');
    }
  }
}