import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../commons.dart';
import 'package:http/http.dart' as http;
part 'history_controller.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  createState() => _HistoryScreen();
}

class _HistoryScreen extends HistoryController {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white54,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          // side: BorderSide(
          //   color: Colors.grey,
          // ),
        ),
        title: const Text(
          'Real-Time Data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            // color: Color(
            //   0xFF305680,
            // ),
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
                  const SizedBox(width: 5,),
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
          /*DropdownButton<EntityData>(
                    hint: const Text('Select a device'), // Placeholder
                    value: selectedDevice, // Selected value
                    items: devices.data.map((EntityData device) {
                      return DropdownMenuItem<EntityData>(
                        value: device,
                        child: Text('${device.latest[EntityKeyType.ENTITY_FIELD]?['name']!.value}'), // Display the name property
                      );
                    }).toList(),
                    onChanged: (EntityData? newValue) {
                      setState(() {
                        selectedDevice = newValue!; // Update selected device
                      });
                    },
                  ),*/
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Voltage',style: TextStyle(color: Color(0xFF305680),fontWeight: FontWeight.w600, fontSize: 24,),),
              ),
              SizedBox(
                // width: width * .95,
                height: height * .35,
                child: LineChart(
                  LineChartData(
                    // minY: 150,
                    titlesData: FlTitlesData(
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() % 5 != 0) return const SizedBox.shrink();
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
                    lineBarsData: [
                      LineChartBarData(
                        show: graphs[0],
                        spots: _getChartData(telemetryData, keys[0]),
                        isCurved: false,
                        color: Colors.blue,
                        dotData: const FlDotData(show: false),
                        barWidth: 1,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        show: graphs[1],
                        spots: _getChartData(telemetryData, keys[1]),
                        isCurved: false,
                        color: Colors.red,
                        dotData: const FlDotData(show: false),
                        barWidth: 1,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        show: graphs[2],
                        spots: _getChartData(telemetryData, keys[2]),
                        isCurved: false,
                        color: Colors.yellow.shade700,
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
                  _buildIndicator(keys[0], Colors.blue),
                  const SizedBox(width: 20),
                  _buildIndicator(keys[1], Colors.red),
                  const SizedBox(width: 20),
                  _buildIndicator(keys[2], Colors.yellow.shade700),
                ],
              ),
              const SizedBox(height: 10,),
              const Divider(),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Current',style: TextStyle(color: Color(0xFF305680),fontWeight: FontWeight.w600, fontSize: 24,),),
              ),
              SizedBox(
                width: width * .95,
                height: height * .35,
                child: LineChart(
                  LineChartData(
                    // minY: 0,
                    // maxY: 1200,
                    titlesData: FlTitlesData(
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() % 5 != 0) return const SizedBox.shrink();
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
                    lineBarsData: [
                      LineChartBarData(
                        show: graphs[3],
                        spots: _getChartData(telemetryData, keys[3]),
                        isCurved: false,
                        color: Colors.orange,
                        dotData: const FlDotData(show: false),
                        barWidth: 1,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        show: graphs[4],
                        spots: _getChartData(telemetryData, keys[4]),
                        isCurved: false,
                        color: Colors.grey,
                        dotData: const FlDotData(show: false),
                        barWidth: 1,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        show: graphs[5],
                        spots: _getChartData(telemetryData, keys[5]),
                        isCurved: false,
                        color: Colors.pink,
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
                  _buildIndicator(keys[3], Colors.orange),
                  const SizedBox(width: 20),
                  _buildIndicator(keys[4], Colors.grey),
                  const SizedBox(width: 20),
                  _buildIndicator(keys[5], Colors.pink),
                ],
              ),
              const SizedBox(height: 10,),
              const Divider(),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0,),
                child: Text('Temperature',style: TextStyle(color: Color(0xFF305680),fontWeight: FontWeight.w600, fontSize: 24,),),
              ),
              SizedBox(
                width: width * .95,
                height: height * .35,
                child: LineChart(
                  LineChartData(
                    // minY: 0,
                    titlesData: FlTitlesData(
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() % 10 != 0) return const SizedBox.shrink();
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
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 17),),
        ],
      ),
      onTap: (){
        print('tapping');
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