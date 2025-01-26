part of 'realtime_screen.dart';

abstract class RealtimeController extends State<RealtimeScreen> {

  /*late Map<String, dynamic> timeSeriesData;
  late Map<String, TsValue> timeSeries;

  @override
  void initState() {
    super.initState();
    timeSeries = widget.device.latest[EntityKeyType.TIME_SERIES] ?? {};
    timeSeriesData = extractTimeSeries(timeSeries);
    print(timeSeriesData);
  }

  Map<String, dynamic> extractTimeSeries(Map<String, TsValue> timeSeries) {
    return timeSeries.map((key, value) => MapEntry(key, value.value));
  }
  final entityFilter = EntityTypeFilter(entityType: EntityType.DEVICE);*/


  ///first
  /*late Map<String, dynamic> timeSeriesData;
  late Map<String, TsValue> timeSeries;
  late Stream<Map<String, dynamic>> timeSeriesStream;

  @override
  void initState() {
    super.initState();
    timeSeriesStream = Stream.periodic(
      const Duration(seconds: 2),
          (_) {
        timeSeries = widget.device.latest[EntityKeyType.TIME_SERIES] ?? {};
        return extractTimeSeries(timeSeries);
      },
    ).asBroadcastStream();
  }

  Map<String, dynamic> extractTimeSeries(Map<String, TsValue> timeSeries) {
    return timeSeries.map((key, value) => MapEntry(key, value.value));
  }

  final entityFilter = EntityTypeFilter(entityType: EntityType.DEVICE);*/

  ///second
  /*late Map<String, dynamic> timeSeriesData;
  late Map<String, TsValue> timeSeries;
  late Stream<Map<String, dynamic>> timeSeriesStream;

  @override
  void initState() {
    super.initState();
    fetchInitial();
    timeSeriesStream = Stream.periodic(
      const Duration(seconds: 2),
          (_) {
        timeSeries = widget.device.latest[EntityKeyType.TIME_SERIES] ?? {};
        return extractTimeSeries(timeSeries);
      },
    ).asBroadcastStream();
  }

  Map<String, dynamic> extractTimeSeries(Map<String, TsValue> timeSeries) {
    return timeSeries.map((key, value) => MapEntry(key, value.value));
  }

  final entityFilter = EntityTypeFilter(entityType: EntityType.DEVICE);

  Future<void> fetchInitial () async{
      final endTime = DateTime.now().millisecondsSinceEpoch;
      final startTime = DateTime.now()
          .subtract(const Duration(days: 14))
          .millisecondsSinceEpoch;
      telemetryData = await fetchTelemetryData(
        widget.device.entityId.id!,
        keys,
        startTime,
        endTime,
      );
      print(telemetryData);
      telemetryData['v1']?.forEach((key, value) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(key);
        print('Time: ${dateTime.toIso8601String()}, Value: $value');
      });
      print('Telemetry Data: $telemetryData');
    }

  Future<Map<String, Map<int, dynamic>>> fetchTelemetryData(
      String deviceId, List<String> keys, int startTime, int endTime) async {
    final url =
        '$thingsBoardApiEndpoint/api/plugins/telemetry/DEVICE/$deviceId/values/timeseries?keys=${keys.join(',')}&startTs=$startTime&endTs=$endTime';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-Authorization': 'Bearer ${tbClient.getJwtToken()}',
      },
    );
    print(response.statusCode);

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
  }*/

  ///third
  late Stream<Map<String, Map<int, dynamic>>> timeSeriesStream;

  bool isRunning = false;
  @override
  void initState() {
    super.initState();
    isRunning = true;
    fetchTelemetryInLoop(widget.device.entityId.id!,keys);
    // fetchLatestTelemetryData(widget.device.entityId.id!, keys);
    // fetchLatestTelemetryStream();
    // timeSeriesStream = fetchTelemetryStream();
  }

  /*Stream<Map<String, Map<int, dynamic>>> fetchTelemetryStream() async* {
    while (true) {
      try {
        final endTime = DateTime.now().millisecondsSinceEpoch;
        final startTime = DateTime.now()
            .subtract(const Duration(days: 14))
            .millisecondsSinceEpoch;

        final telemetryData = await fetchTelemetryData(
          widget.device.entityId.id!,
          keys,
          startTime,
          endTime,
        );

        print('Telemetry Data: $timeSeriesStream');
        yield telemetryData; // Emit the fetched data.
      } catch (e) {
        print('Error fetching telemetry data: $e');
        yield {}; // Emit an empty map in case of errors.
      }

      // Wait for 2 seconds before fetching again.
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<Map<String, Map<int, dynamic>>> fetchTelemetryData(
      String deviceId, List<String> keys, int startTime, int endTime) async {
    final url =
        '$thingsBoardApiEndpoint/api/plugins/telemetry/DEVICE/$deviceId/values/timeseries?keys=${keys.join(',')}&startTs=$startTime&endTs=$endTime';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-Authorization': 'Bearer ${tbClient.getJwtToken()}',
      },
    );
    print(response.statusCode);

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
  }*/
  Map<String,dynamic> latestValues = {};

    /*Stream<Map<String, dynamic>> fetchLatestTelemetryStream() async* {
      try {
        await Future.delayed(const Duration(seconds: 2));
        final latestTelemetry = await fetchLatestTelemetryData(
          widget.device.entityId.id!,
          keys,
        );
        print('Latest Telemetry: $latestTelemetry');
        latestValues = latestTelemetry;
        yield latestTelemetry;
      } catch (e) {
        print('Error fetching telemetry data: $e');
        yield {}; // Emit an empty map in case of errors
      }
  }
  Future<Map<String, dynamic>> fetchLatestTelemetryData(
      String deviceId, List<String> keys) async {
      print('here inside fetching');
    final url =
        '$thingsBoardApiEndpoint/api/plugins/telemetry/DEVICE/$deviceId/values/timeseries?keys=${keys.join(',')}';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-Authorization': 'Bearer ${tbClient.getJwtToken()}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // Extract the latest value for each key
      return data.map((key, valueList) {
        final latestEntry = valueList.last; // Assuming the last entry is the latest
        return MapEntry(key, latestEntry['value']);
      });
    } else {
      throw Exception(
          'Failed to fetch telemetry data: ${response.statusCode} ${response.body}');
    }
  }*/

  /*Stream<Map<String, dynamic>> fetchLatestTelemetryStream() async* {
    try {
      await Future.delayed(const Duration(seconds: 2)); // Optional delay
      final latestTelemetry = await fetchLatestTelemetryData(
        widget.device.entityId.id!,
        keys,
      );
      print('Latest Telemetry: $latestTelemetry');
      latestValues = latestTelemetry;
      yield latestTelemetry;
    } catch (e) {
      print('Error fetching telemetry data: $e');
      yield {}; // Emit an empty map in case of errors
    }
  }*/
  Future<void> fetchTelemetryInLoop(String deviceId, List<String> keys) async {
    while (isRunning) {
      try {
        // Fetch the latest telemetry data
        final latestTelemetry = await fetchLatestTelemetryData(deviceId, keys);
        if (kDebugMode) {
          print('Latest Telemetry: $latestTelemetry');
        }

      } catch (e) {
        if (kDebugMode) {
          print('Error fetching telemetry data: $e');
        }
      }

      // Add a delay before the next fetch
      await Future.delayed(const Duration(milliseconds: 30));
    }
  }

  Future<Map<String, dynamic>> fetchLatestTelemetryData(
      String deviceId, List<String> keys) async {
    if (kDebugMode) {
      print('Fetching telemetry data...');
    }
    try {
      // Use the concrete subclass `DeviceId`
      final entityId = DeviceId(deviceId);

      final timeSeries = await tbClient.getAttributeService().getTimeseries(
        entityId,
        keys,
        limit: 1, // Fetch only the most recent value
        sortOrder: Direction.DESC, // Get the latest value first
      );

      // Convert the List<TsKvEntry> to Map<String, dynamic>
      if(mounted) {
        setState(() {
          latestValues = {
            for (var entry in timeSeries) entry.getKey(): entry.getValue(),
          };
        });
      }

      return latestValues;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching telemetry data: $e');
      }
      throw Exception('Failed to fetch telemetry data: $e');
    }
  }


  @override
  void dispose(){
    super.dispose();
    isRunning = false;
  }

}