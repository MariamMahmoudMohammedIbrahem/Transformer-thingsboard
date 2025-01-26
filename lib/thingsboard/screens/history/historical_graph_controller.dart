part of 'historical_graph_screen.dart';

abstract class HistoricalGraphController
    extends State<HistoricalGraphScreen> {


  var selectedDevice = devices.data[1];
  String? selectedName = devices.data.first.latest[EntityKeyType.ENTITY_FIELD]?['name']?.value; // Initialize selectedName as the first device's name
  @override
  void initState() {
    historical();
    super.initState();
  }

  Future<void> historical() async{
    // while(true) {
      final endTime = DateTime
          .now()
          .millisecondsSinceEpoch;
      final startTime = DateTime
          .now()
          .subtract(const Duration(days: 30))
          .millisecondsSinceEpoch;
      final fetchedData = await fetchHistoryData(
        selectedDevice.entityId.id!,
        keys,
        startTime,
        endTime,
      );
      setState(() {
        telemetryData = fetchedData;
      });
      if (kDebugMode) {
        print(telemetryData);
      }
      // Future.delayed(const Duration(seconds: 5),);
    // }
  }
  Future<Map<String, Map<int, dynamic>>> fetchHistoryData(
      String deviceId, List<String> keys, int startTime, int endTime) async {
    final url =
        '$thingsBoardApiEndpoint/api/plugins/telemetry/DEVICE/$deviceId/values/timeseries?keys=${keys.join(',')}&startTs=$startTime&endTs=$endTime';
    if (kDebugMode) {
      print("url: ${Uri.parse(url)}");
      print("jwt token: ${tbClient.getJwtToken()}");
    }
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-Authorization': 'Bearer ${tbClient.getJwtToken()}',
      },
    );
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        print('data $data');
      }
      return data.map((key, valueList) {
        return MapEntry(
          key,
          {for (var item in valueList) item['ts'] as int: item['value']},
        );
      });
    } else {
      throw Exception(
          'Failed to fetch telemetry data: ${response.statusCode} ${response.body}');
    }
  }
}