// realtime_controller.dart

// fetch latest data using stream
// test 1
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
}*/

// test 2
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

// fetch real-time data
// test 1
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
}*/

// test 2
/*Future<Map<String, Map<int, dynamic>>> fetchTelemetryData(
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

// init state test 1
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

// init state test 2
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


// fetch latest data using future
/*Future<Map<String, dynamic>> fetchLatestTelemetryData(
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

// realtime_graph_controller.dart

// getting the spots for the fl_chart
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

// dashboard_controller.dart

// fetching devices
// test1
/*Stream<PageData<EntityData>> fetchDevicesStream() async* {
    try {
      devicesQuery = EntityDataQuery(
        entityFilter: entityFilter,
        keyFilters: [],
        entityFields: deviceFields,
        latestValues: keys
            .map((key) => EntityKey(type: EntityKeyType.TIME_SERIES, key: key))
            .toList(),
        pageLink: EntityDataPageLink(
          pageSize: 10,
          sortOrder: EntityDataSortOrder(
            key: EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'createdTime'),
            direction: EntityDataSortOrderDirection.DESC,
          ),
        ),
      );

      while (true) {
        gettingDevicesCount();
        devices = await tbClient
            .getEntityQueryService()
            .findEntityDataByQuery(devicesQuery);
        yield devices;

        await Future.delayed(const Duration(seconds: 2));
      }
    } catch (e, s) {
      print('Error: $e');
      print('Stack: $s');
    }
  }*/

// test2
/*Stream<PageData<EntityData>> fetchDevicesStream() async* {
  try {
    devicesQuery = EntityDataQuery(
      entityFilter: entityFilter,
      keyFilters: [], // No filtering for now; we fetch all and classify later
      entityFields: deviceFields,
      latestValues: keys
          .map((key) => EntityKey(type: EntityKeyType.TIME_SERIES, key: key))
          .toList(),
      pageLink: EntityDataPageLink(
        pageSize: 10,
        sortOrder: EntityDataSortOrder(
          key: EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'createdTime'),
          direction: EntityDataSortOrderDirection.DESC,
        ),
      ),
    );

    while (true) {
      devices = await tbClient
          .getEntityQueryService()
          .findEntityDataByQuery(devicesQuery);

      // Map over devices to append 'active' or 'inactive' status
      var devicesWithStatus = devices.data.map((device) {
        var isActive = device.attribute('active')?.toLowerCase() == 'true';
        print('device.latest: ${device.latest}');

        return EntityDataWithStatus(
          entityData: device,
          status: isActive ? 'active' : 'inactive',
        );
      }).toList();

// Convert back to List<EntityData> if needed
      List<EntityData> entityDataList = devicesWithStatus.map((e) => e.entityData).toList();
// print('entityDataList $entityDataList');
      yield PageData<EntityData>(
        entityDataList,
        devices.totalPages,
        devices.totalElements,
        devices.hasNext,
      );

      await Future.delayed(const Duration(seconds: 2));
    }
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }
}*/

// trying to get the devices along with their status id + status
/*Stream<PageData<EntityData>> fetchDevicesStream() async* {
    try {
      // Define the key to fetch the 'active' status
      var activeKey = EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active');

      // Define the device query
      devicesQuery = EntityDataQuery(
        entityFilter: entityFilter,
        keyFilters: [],
        latestValues: [activeKey], // Include the 'active' attribute in the latest values
        pageLink: EntityDataPageLink(
          pageSize: 10,
          sortOrder: EntityDataSortOrder(
            key: EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'createdTime'),
            direction: EntityDataSortOrderDirection.DESC,
          ),
        ),
      );

      while (true) {
        // Fetch the devices data
        var devices = await tbClient
            .getEntityQueryService()
            .findEntityDataByQuery(devicesQuery);

        // Process and print devices with their status
        for (var entityData in devices.data) {
          // Use entityId for device identification
          var entityId = entityData.entityId.id;
          var activeStatus = entityData.latest[EntityKeyType.ATTRIBUTE]?['active']?.value ?? 'Inactive';
          print('Device ID: $entityId, Status: ${activeStatus == true ? "Active" : "Inactive"}');
        }

        yield devices;

        // Delay before the next fetch
        await Future.delayed(const Duration(seconds: 2));
      }
    } catch (e, s) {
      print('Error: $e');
      print('Stack: $s');
    }
  }*/

// getting the count of the devices
/*Future<void> gettingDevicesCount () async{
  // Create entity filter to get all devices
  var entityFilter = EntityTypeFilter(entityType: EntityType.DEVICE);

  // Create entity count query with provided filter
  var devicesQuery = EntityCountQuery(entityFilter: entityFilter);
  var activeDeviceKeyFilter = KeyFilter(
      key: EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active'),
      valueType: EntityKeyValueType.BOOLEAN,
      predicate: BooleanFilterPredicate(
          operation: BooleanOperation.EQUAL,
          value: FilterPredicateValue(true)));

  devicesQuery.keyFilters = [activeDeviceKeyFilter];

  // Execute entity count query and get total active devices count
  var activeDevicesCount = await tbClient.getEntityQueryService().countEntitiesByQuery(devicesQuery);

  print('Active devices:$activeDevicesCount');

  // Set key filter to existing query to get only inactive devices
  var inactiveDeviceKeyFilter = KeyFilter(
  key: EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active'),
  valueType: EntityKeyValueType.BOOLEAN,
  predicate: BooleanFilterPredicate(
  operation: BooleanOperation.EQUAL,
  value: FilterPredicateValue(false)));
  devicesQuery.keyFilters = [inactiveDeviceKeyFilter];

  // Execute entity count query and get total inactive devices count
  var inactiveDevicesCount =
  await tbClient.getEntityQueryService().countEntitiesByQuery(devicesQuery);
  print('Inactive devices: $inactiveDevicesCount');
}*/

// check connection
/*void checkConnection () async{
    var connectivityResult = Connectivity().onConnectivityChanged;
    connectivityResult.listen((event) {
      print('event $event');
      if(event.first != ConnectivityResult.none){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const AutoSignInScreen(),),);
      }
    });
  }*/

// forget_password_controller.dart
/*Future<void> resetPassword(String email) async {
    final url = Uri.parse('$thingsBoardApiEndpoint/api/noauth/resetPassword');

    try {
      setState(() {
        _isLoading = true;
      });

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Password reset email sent successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        final responseBody = json.decode(response.body);
        throw Exception(responseBody['message'] ?? 'Failed to reset password.');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }*/


/*class InternetConnectionService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionChangeController =
  StreamController<bool>.broadcast();

  InternetConnectionService() {
    _connectivity.onConnectivityChanged.listen((results) {
      // Pass the first result in the list to _checkConnectionStatus
      if (results.isNotEmpty) {
        _checkConnectionStatus(results.first);
      }
    });
  }

  Stream<bool> get connectionChange => _connectionChangeController.stream;

  void _checkConnectionStatus(ConnectivityResult result) {
    final bool isConnected = result != ConnectivityResult.none;
    _connectionChangeController.add(isConnected);
  }

  void dispose() {
    _connectionChangeController.close();
  }
}*/

// old main
/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();
  // HttpOverrides.global = MyHttpOverrides();
  await tbClient.login(LoginRequest('doaamahmed678@gmail.com', 'EoipEgypt'));
  token = tbClient.getJwtToken()!;
  print('token $token');
      runApp(
        ChangeNotifierProvider(
          create: (context) => AppProvider(),
          child: const MyApp(),
        ),
      );
}*/

/*
final notifications = FlutterLocalNotificationsPlugin();
void initializeNotifications() {
  notifications.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveBackgroundNotificationResponse: backgroundHandler,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {

        await notifications.cancel(response.id!);
      }
    },
  );
}
void backgroundHandler(NotificationResponse response) async {
  if (response.payload != null) {
    await notifications.cancel(response.id!);
  }
}*/