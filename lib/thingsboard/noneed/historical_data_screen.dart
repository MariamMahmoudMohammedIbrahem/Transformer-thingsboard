/*

import '../commons.dart';

class HistoricalDataScreen extends StatefulWidget {
  const HistoricalDataScreen({super.key});

  @override
  HistoricalDataScreenState createState() => HistoricalDataScreenState();
}

class HistoricalDataScreenState extends State<HistoricalDataScreen> {
  String selectedRange = 'Day';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        title: const Text(
          'Historical Data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(
              0xFF305680,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*0.07),
          child: ListView(
            shrinkWrap: true,
            children: [
              // Time Range Selector
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['Hour', 'Day', 'Week'].map((range) {
                    return ChoiceChip(
                      label: Text(range),
                      selected: selectedRange == range,
                      onSelected: (isSelected) {
                        setState(() {
                          selectedRange = range;
                        });
                        ///TODO: Fetch data based on selected range
                      },
                    );
                  }).toList(),
                ),
              ),
              // Chart Area
              SizedBox(
                width: width * .9,
                height: height * .35,
                child: LineChart(
                  LineChartData(
                    titlesData: const FlTitlesData(
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _getChartData(telemetryData, keys[0]),
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 2,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: _getChartData(telemetryData, keys[1]),
                        isCurved: true,
                        color: Colors.red,
                        barWidth: 2,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: _getChartData(telemetryData, keys[2]),
                        isCurved: true,
                        color: Colors.yellow,
                        barWidth: 2,
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIndicator(keys[0], Colors.blue),
                  const SizedBox(width: 10),
                  _buildIndicator(keys[1], Colors.red),
                  const SizedBox(width: 10),
                  _buildIndicator(keys[2], Colors.yellow),
                ],
              ),
              const Divider(),
              SizedBox(
                width: width * .95,
                height: height * .35,
                child: LineChart(
                  LineChartData(
                    titlesData: const FlTitlesData(
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _getChartData(telemetryData, keys[3]),
                        isCurved: true,
                        color: Colors.orange,
                        barWidth: 2,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: _getChartData(telemetryData, keys[4]),
                        isCurved: true,
                        color: Colors.grey,
                        barWidth: 2,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: _getChartData(telemetryData, keys[5]),
                        isCurved: true,
                        color: Colors.pink,
                        barWidth: 2,
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIndicator(keys[3], Colors.orange),
                  const SizedBox(width: 10),
                  _buildIndicator(keys[4], Colors.grey),
                  const SizedBox(width: 10),
                  _buildIndicator(keys[5], Colors.pink),
                ],
              ),
              const Divider(),
              SizedBox(
                width: width * .95,
                height: height * .35,
                child: LineChart(
                  LineChartData(
                    titlesData: const FlTitlesData(
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _getChartData(telemetryData, keys[6]),
                        isCurved: true,
                        color: Colors.green,
                        barWidth: 2,
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIndicator(keys[6], Colors.green),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  */
/*List<FlSpot> _getChartData(Map<String, Map<int, dynamic>> timeSeries, String key) {
    if (timeSeries.containsKey(key)) {
      return convertToFlSpots(timeSeries[key]!);
    } else {
      return [];
    }
  }*//*



  List<FlSpot> _getChartData(
      Map<String, Map<int, dynamic>> timeSeries, String key) {
    if (!timeSeries.containsKey(key)) return [];

    final data = timeSeries[key]!;

    if (selectedRange == 'Hour') {
      // Group data by hour
      final groupedByHour = <int, List<double>>{};
      data.forEach((timestamp, value) {
        final hour = DateTime.fromMillisecondsSinceEpoch(timestamp).hour;
        groupedByHour.putIfAbsent(hour, () => []).add(double.parse(value));
      });

      // Convert grouped data to FlSpots (average values for each hour)
      return groupedByHour.entries
          .map((entry) => FlSpot(entry.key.toDouble(),
          entry.value.reduce((a, b) => a + b) / entry.value.length))
          .toList();
    } else if (selectedRange == 'Day') {
      // Group data by day
      final groupedByDay = <int, List<double>>{};
      data.forEach((timestamp, value) {
        final day = DateTime.fromMillisecondsSinceEpoch(timestamp).day;
        groupedByDay.putIfAbsent(day, () => []).add(double.parse(value));
      });

      // Convert grouped data to FlSpots (average values for each day)
      return groupedByDay.entries
          .map((entry) => FlSpot(entry.key.toDouble(),
          entry.value.reduce((a, b) => a + b) / entry.value.length))
          .toList();
    } else {
      // Default: map data without grouping
      return data.entries
          .map((entry) => FlSpot(
          DateTime.fromMillisecondsSinceEpoch(entry.key).millisecondsSinceEpoch
              .toDouble(),
          double.parse(entry.value)))
          .toList();
    }
  }


  */
/*List<FlSpot> convertToFlSpots(Map<int, dynamic> data) {
    return data.entries
        .map((entry) => FlSpot(double.parse('${DateTime.fromMillisecondsSinceEpoch(entry.key).hour}'), double.parse(entry.value)))
        .toList();
  }*//*


  Widget _buildIndicator(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
*/
