part of 'realtime_graph_screen.dart';

abstract class RealtimeGraphController extends State<RealtimeGraphScreen> {

  String selectedRange = 'Day';
  var selectedDevice = devices.data.first;
  String? selectedName = devices.data.first.latest[EntityKeyType.ENTITY_FIELD]?['name']?.value; // Initialize selectedName as the first device's name
  bool isRunning = true;

  List<bool> graphs = [true, true, true, true, true, true, true];
  @override
  void initState(){
    super.initState();
    try {
      devices;
      historical();
    } catch (e) {
      throw Exception("devices is empty $e");
    }
  }
  Future<void> historical() async{
    while(isRunning) {
      try {
        final endTime = DateTime
            .now()
            .millisecondsSinceEpoch;
        final startTime = DateTime
            .now()
            .subtract(const Duration(days: 1))
            .millisecondsSinceEpoch;
        final fetchedData = await fetchHistoryData(
          selectedDevice.entityId.id!,
          keys,
          startTime,
          endTime,
        );
        if (mounted) {
          setState(() {
            telemetryData = fetchedData;
          });
        }
        Future.delayed(const Duration(seconds: 5),);
      }
      catch(e){
        throw Exception("Failed to fetch history data for the real-time graph $e");
      }
    }
  }
  Future<Map<String, Map<int, dynamic>>> fetchHistoryData(
      String deviceId, List<String> keys, int startTime, int endTime) async {
    final url =
        '$thingsBoardApiEndpoint/api/plugins/telemetry/DEVICE/$deviceId/values/timeseries?keys=${keys.join(',')}&startTs=$startTime&endTs=$endTime';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-Authorization': 'Bearer ${tbClient.getJwtToken()}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
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

  List<FlSpot> _getChartData(
      Map<String, Map<int, dynamic>> timeSeries, String key) {
    if (!timeSeries.containsKey(key)) return [];

    final data = timeSeries[key]!;
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

    // Filter data to include only entries from the start of the day
    final filteredData = data.entries
        .where((entry) => entry.key >= startOfDay)
        .map((entry) => MapEntry(entry.key, double.parse(entry.value)));

    // Convert filtered data to FlSpots
    return filteredData
        .map((entry) => FlSpot(
            DateTime.fromMillisecondsSinceEpoch(entry.key).millisecondsSinceEpoch
                .toDouble(),
            entry.value))
        .toList();
}

  List<LineChartBarData> _getLineBarsData(List<int> indexes) {
    return [
      LineChartBarData(
        show: graphs[indexes[0]],
        spots: _getChartData(telemetryData, keys[indexes[0]]),
        isCurved: false,
        color: Colors.blue,
        dotData: const FlDotData(show: false),
        barWidth: 1,
        belowBarData: BarAreaData(show: false),
      ),
      LineChartBarData(
        show: graphs[indexes[1]],
        spots: _getChartData(telemetryData, keys[indexes[1]]),
        isCurved: false,
        color: Colors.red,
        dotData: const FlDotData(show: false),
        barWidth: 1,
        belowBarData: BarAreaData(show: false),
      ),
      LineChartBarData(
        show: graphs[indexes[2]],
        spots: _getChartData(telemetryData, keys[indexes[2]]),
        isCurved: false,
        color: Colors.yellow.shade700,
        dotData: const FlDotData(show: false),
        barWidth: 1,
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  double _calculateMaxY(List<int> indexes) {
    final allValues = [
      ..._getChartData(telemetryData, keys[indexes[0]]).map((spot) => spot.y),
      ..._getChartData(telemetryData, keys[indexes[1]]).map((spot) => spot.y),
      ..._getChartData(telemetryData, keys[indexes[2]]).map((spot) => spot.y),
    ];
    return allValues.isNotEmpty ? allValues.reduce((a, b) => a > b ? a : b) : 0;
  }

  @override
  void dispose() {
    super.dispose();
    isRunning = false;
  }
}