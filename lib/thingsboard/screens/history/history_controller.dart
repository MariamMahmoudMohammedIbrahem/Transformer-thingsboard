part of 'history_screen.dart';

abstract class HistoryController extends State<HistoryScreen> {

  String selectedRange = 'Day';
  var selectedDevice = devices.data.first;
  String? selectedName = devices.data.first.latest[EntityKeyType.ENTITY_FIELD]?['name']?.value; // Initialize selectedName as the first device's name
  // var selectedDeviceName = devices.data.first.e;

  List<bool> graphs = [true, true, true, true, true, true, true];
  @override
  void initState(){
    print('object');
    super.initState();
    try {
      print('devices $devices');
      devices;
      historical();
    } catch (e) {
        print('Devices have not been initialized');
    }
  }
  Future<void> historical() async{
    print('in historical data');
    while(true) {
      // var firstDevice = devices.data[2];
      // var firstDeviceId = firstDevice.entityId.id;
      // print('firstDevice $firstDevice');
      // print('first device id$firstDeviceId');
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
      setState(() {
        telemetryData = fetchedData;
      });
      print(telemetryData);
      Future.delayed(const Duration(seconds: 5),);
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
    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      print('data $data');
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

  /*List<FlSpot> _getChartData(
      Map<String, Map<int, dynamic>> timeSeries, String key) {
    if (!timeSeries.containsKey(key)) return [];

    final data = timeSeries[key]!;
    print(data.length);
    final now = DateTime.now();
    if (selectedRange == 'Hour') {
      // Group data by hour
      *//*print(data);
      final groupedByHour = <int, List<double>>{};
      data.forEach((timestamp, value) {
        final hour = DateTime.fromMillisecondsSinceEpoch(timestamp).hour;
        groupedByHour.putIfAbsent(hour, () => []).add(double.parse(value));
      });

      print('selectedRange in hour total $groupedByHour');
      print('selectedRange in hour total ${groupedByHour.length}');
      print('selectedRange return ${groupedByHour.entries
          .map((entry) => FlSpot(entry.key.toDouble(),
          entry.value.reduce((a, b) => a + b) / entry.value.length))
          .toList()}');
      // Convert grouped data to FlSpots (average values for each hour)
      return groupedByHour.entries
          .map((entry) => FlSpot(entry.key.toDouble(),
          entry.value.reduce((a, b) => a + b) / entry.value.length))
          .toList();*//*
      final oneHourAgo = now.subtract(const Duration(hours: 1)).millisecondsSinceEpoch;
      final filteredData = data.entries
          .where((entry) => entry.key >= oneHourAgo)
          .map((entry) => MapEntry(entry.key, double.parse(entry.value)));

      print('Filtered data for the last hour: ${filteredData.length}');
      print('Filtered data for the last hour: ${filteredData
          .map((entry) => FlSpot(
          DateTime.fromMillisecondsSinceEpoch(entry.key).millisecondsSinceEpoch
              .toDouble(),
          entry.value))
          .toList()}');

      // Convert filtered data to FlSpots
      return filteredData
          .map((entry) => FlSpot(
          DateTime.fromMillisecondsSinceEpoch(entry.key).millisecondsSinceEpoch
              .toDouble(),
          entry.value))
          .toList();
    } else if (selectedRange == 'Day') {
      *//*//*/ Group data by day
      final groupedByDay = <int, List<double>>{};
      data.forEach((timestamp, value) {
        final day = DateTime.fromMillisecondsSinceEpoch(timestamp).day;
        groupedByDay.putIfAbsent(day, () => []).add(double.parse(value));
      });
      print('selectedRange $groupedByDay');
      // Convert grouped data to FlSpots (average values for each day)
      return groupedByDay.entries
          .map((entry) => FlSpot(entry.key.toDouble(),
          entry.value.reduce((a, b) => a + b) / entry.value.length))
          .toList();*//*
      // Create a map for 48 half-hour intervals in a day
      // Create a map for 48 half-hour intervals in a day
      final groupedByHalfHour = <int, double?>{};
      final startOfDay = DateTime(now.year, now.month, now.day);

      for (int i = 0; i < 48; i++) {
        final intervalStart = startOfDay.add(Duration(minutes: i * 30)).millisecondsSinceEpoch;
        groupedByHalfHour[intervalStart] = null; // Initialize with null
      }

      // Populate data into half-hour intervals
      data.forEach((timestamp, value) {
        final time = DateTime.fromMillisecondsSinceEpoch(timestamp);
        final intervalStart = startOfDay.add(
          Duration(minutes: ((time.hour * 60 + time.minute) ~/ 30) * 30),
        ).millisecondsSinceEpoch;

        if (groupedByHalfHour.containsKey(intervalStart)) {
          groupedByHalfHour[intervalStart] ??= 0;
          groupedByHalfHour[intervalStart] = (groupedByHalfHour[intervalStart]! + double.parse(value)) / 2;
        }
      });

      // Fill missing intervals with the nearest value
      final sortedKeys = groupedByHalfHour.keys.toList()..sort();
      for (int i = 0; i < sortedKeys.length; i++) {
        if (groupedByHalfHour[sortedKeys[i]] == null) {
          double? nearestValue;

          // Look for the nearest value before or after
          for (int j = 1; nearestValue == null && (i - j >= 0 || i + j < sortedKeys.length); j++) {
            if (i - j >= 0 && groupedByHalfHour[sortedKeys[i - j]] != null) {
              nearestValue = groupedByHalfHour[sortedKeys[i - j]];
            } else if (i + j < sortedKeys.length && groupedByHalfHour[sortedKeys[i + j]] != null) {
              nearestValue = groupedByHalfHour[sortedKeys[i + j]];
            }
          }

          groupedByHalfHour[sortedKeys[i]] = nearestValue ?? 0; // Assign nearest value or 0 if none found
        }
      }

      print('Grouped data by half-hour intervals (with nearest values): $groupedByHalfHour');

      // Convert grouped data to FlSpots
      return groupedByHalfHour.entries
          .map((entry) => FlSpot(
          entry.key.toDouble(),
          entry.value ?? 0)) // Use 0 for intervals without data
          .toList();
    }
    else {
      // Default: map data without grouping
      print('selectedRange ${data.length}');
      return data.entries
          .map((entry) => FlSpot(
          DateTime.fromMillisecondsSinceEpoch(entry.key).millisecondsSinceEpoch
              .toDouble(),
          double.parse(entry.value)))
          .toList();
    }
  }*/*/
  List<FlSpot> _getChartData(
      Map<String, Map<int, dynamic>> timeSeries, String key) {
    if (!timeSeries.containsKey(key)) return [];

    final data = timeSeries[key]!;
    // print(data.length);
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

    // Filter data to include only entries from the start of the day
    final filteredData = data.entries
        .where((entry) => entry.key >= startOfDay)
        .map((entry) => MapEntry(entry.key, double.parse(entry.value)));

    print('Filtered data for the day: ${filteredData.length}');

    // Convert filtered data to FlSpots
    return filteredData
        .map((entry) => FlSpot(
            DateTime.fromMillisecondsSinceEpoch(entry.key).millisecondsSinceEpoch
                .toDouble(),
            entry.value))
        .toList();
}

}