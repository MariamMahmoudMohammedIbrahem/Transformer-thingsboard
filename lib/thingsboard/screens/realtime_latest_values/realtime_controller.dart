part of 'realtime_screen.dart';

abstract class RealtimeController extends State<RealtimeScreen> {

  late Stream<Map<String, Map<int, dynamic>>> timeSeriesStream;

  bool isRunning = false;
  @override
  void initState() {
    super.initState();
    isRunning = true;
    fetchTelemetryInLoop(widget.device.entityId.id!,keys);
  }

  Map<String,dynamic> latestValues = {};


  Future<void> fetchTelemetryInLoop(String deviceId, List<String> keys) async {
    while (isRunning) {
      try {
        // Fetch the latest telemetry data
        await fetchLatestTelemetryData(deviceId, keys);
      } catch (e) {
        throw Exception("Failed to Fetch Telemetry Data during while loop $e");
      }

      // Add a delay before the next fetch
      await Future.delayed(const Duration(milliseconds: 30));
    }
  }

  Future<Map<String, dynamic>> fetchLatestTelemetryData(
      String deviceId, List<String> keys) async {
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
      throw Exception('Failed to fetch telemetry data: $e');
    }
  }


  @override
  void dispose(){
    super.dispose();
    isRunning = false;
  }

}