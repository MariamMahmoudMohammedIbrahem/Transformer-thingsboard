
import '../../commons.dart';
import 'package:http/http.dart' as http;
part 'realtime_graph_controller.dart';

class RealtimeGraphScreen extends StatefulWidget {
  const RealtimeGraphScreen({super.key});

  @override
  createState() => _HistoryScreen();
}

class _HistoryScreen extends RealtimeGraphController {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: const Text(
          'Real-Time Data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.07, vertical: 16.0),
        child: Visibility(
          visible: devices.data.isNotEmpty,
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Device', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Color(0xFF305680),),),
                  width5,
                  Flexible(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: devices.data.map((entity) {
                        final name = entity.latest[EntityKeyType.ENTITY_FIELD]?['name']?.value ?? 'Unknown';

                        return DropdownMenuItem<String>(
                          value: name,
                          child: ListTile(
                            title: Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF305680),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      menuMaxHeight: 300.0,
                      onChanged: (newValue) {
                        selectedDevice = devices.data.firstWhere(
                              (entity) => entity.latest[EntityKeyType.ENTITY_FIELD]?['name']?.value == newValue,
                        );
                        selectedName = newValue;
                      },
                      hint: const Text(
                        "Select a device",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF305680),
                        ),
                      ),
                      value: selectedName,
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF305680)),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Voltage',style: TextStyle(color: Color(0xFF305680),fontWeight: FontWeight.w600, fontSize: 24,),),
              ),
              SizedBox(
                height: height * .35,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() % 5 != 0) return kEmptyWidget;
                            final timestamp = value.toInt();
                            final time = DateTime.fromMillisecondsSinceEpoch(timestamp)
                                .toIso8601String()
                                .substring(11, 16); // Format as HH:mm
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 8,
                              child: Text(
                                time,
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            final text = Text(
                              value.toStringAsFixed(1),
                              style: const TextStyle(
                                // color: Colors.black,
                                fontSize: 10,
                              ),
                            );
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 8,
                              child: text,
                            );
                          },
                        ),
                      ),
                    ),
                    lineBarsData: _getLineBarsData([0,1,2]),
                    // minY: 0,
                    maxY: _calculateMaxY([0,1,2]) + 10, // Increase max Y by 10
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIndicator(keys[0], Colors.blue),
                  width20,
                  _buildIndicator(keys[1], Colors.red),
                  width20,
                  _buildIndicator(keys[2], Colors.yellow.shade700),
                ],
              ),
              height10,
              divider,
              height10,
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Current',style: TextStyle(color: Color(0xFF305680),fontWeight: FontWeight.w600, fontSize: 24,),),
              ),
              SizedBox(
                width: width * .95,
                height: height * .35,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() % 5 != 0) return kEmptyWidget;
                            final timestamp = value.toInt();
                            final time = DateTime.fromMillisecondsSinceEpoch(timestamp)
                                .toIso8601String()
                                .substring(11, 16); // Format as HH:mm
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 8,
                                child: Text(
                                  time,
                                  style: const TextStyle(fontSize: 10),
                                ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            final text = Text(
                              value.toStringAsFixed(1),
                              style: const TextStyle(
                                // color: Colors.black,
                                fontSize: 10,
                              ),
                            );
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 8,
                              child: text,
                            );
                          },
                        ),
                      ),
                    ),
                    lineBarsData: _getLineBarsData([3,4,5]),
                    maxY: _calculateMaxY([3,4,5]) + 10, // Increase max Y by 10
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIndicator(keys[3], Colors.blue),
                  width20,
                  _buildIndicator(keys[4], Colors.red),
                  width20,
                  _buildIndicator(keys[5], Colors.yellow.shade700),
                ],
              ),
              height10,
              divider,
              height10,
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0,),
                child: Text('Temperature',style: TextStyle(color: Color(0xFF305680),fontWeight: FontWeight.w600, fontSize: 24,),),
              ),
              SizedBox(
                width: width * .95,
                height: height * .35,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() % 10 != 0) return kEmptyWidget;
                            final timestamp = value.toInt();
                            final time = DateTime.fromMillisecondsSinceEpoch(timestamp)
                                .toIso8601String()
                                .substring(11, 16); // Format as HH:mm
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 8,
                                child: Text(
                                  time,
                                  style: const TextStyle(fontSize: 10),
                                ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            final text = Text(
                              value.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            );
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 8,
                              child: text,
                            );
                          },
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _getChartData(telemetryData, keys[6]),
                        isCurved: false,
                        color: Colors.green,
                        dotData: const FlDotData(show: false),
                        barWidth: 1,
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

  Widget _buildIndicator(String label, Color color) {
    return GestureDetector(
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          width4,
          Text(label, style: const TextStyle(fontSize: 17),),
        ],
      ),
      onTap: (){
        switch (label){
          case 'v1':
            if(graphs[1]||graphs[2]){
              graphs[0] = !graphs[0];
            }
            break;
          case 'v2':
            if(graphs[0]||graphs[2]){
              graphs[1] = !graphs[1];
            }
            break;
          case 'v3':
            if(graphs[0]||graphs[1]){
              graphs[2] = !graphs[2];
            }
            break;
          case 'i1':
            if(graphs[4]||graphs[5]){
              graphs[3] = !graphs[3];
            }
            break;
          case 'i2':
            if(graphs[3]||graphs[5]){
              graphs[4] = !graphs[4];
            }
            break;
          case 'i3':
            if(graphs[3]||graphs[4]){
              graphs[5] = !graphs[5];
            }
            break;
          default:
            break;
        }
      },
    );
  }
}