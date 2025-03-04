/*

import '../../commons.dart';

class NavigationController extends GetxController {
  Rx<int> selectedIndex = 1.obs;

  final screens = [
    const HistoryScreen(),
    const DashboardScreen(),
    const SettingsScreen(),
  ];
}

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          shadowColor: Colors.grey,
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => {
            controller.selectedIndex.value = index,
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.history_toggle_off),
              label: 'History',
            ),
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_rounded),
              label: 'Settings',
            ),
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.screens,
        ),
      ),
    );
  }
}
*/

/*lineBarsData: [
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
                    ],*/


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


/*SizedBox(
            child: StreamBuilder<Map<String, dynamic>>(
                stream: fetchLatestTelemetryStream(),
                builder: (context, snapshot) {
                  print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: SizedBox.shrink());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            }

                  // final telemetryData = snapshot.data!;
                  // return Container(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Text('Telemetry Data: $telemetryData'),
                  // );
                  return kEmptyWidget;
                }
            ),
          ),*/

// dashboard_screen.dart
/*FutureBuilder<PageData<EntityData>>(
                future: fetchDevices(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No data available'));
                  }

                  final devices = snapshot.data!;
                  return Expanded(
                    child: toggle
                        ? ListView.builder(
                      itemCount: devices.data.length,
                      itemBuilder: (context, index) {
                        final entity = devices.data[index];
                        final name = entity
                            .latest[EntityKeyType.ENTITY_FIELD]
                        ?['name']
                            ?.value ??
                            'Unknown';
                        final type = entity
                            .latest[EntityKeyType.ENTITY_FIELD]
                        ?['type']
                            ?.value ??
                            'Unknown';
                        return ListTile(
                          leading: const Icon(
                            Icons.transform_rounded,
                            color: Color(0xFF305680),
                          ),
                          title: Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(
                                0xFF305680,
                              ),
                            ),
                          ),
                          subtitle: Text(type,
                              style: const TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              )),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RealtimeScreen(
                                  device: devices.data[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                        : GridView.builder(
                        gridDelegate:
                        SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: width * 0.45,
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                          mainAxisExtent: height * .27,
                        ),
                        itemCount: devices.data.length,
                        itemBuilder: (context, index) {
                          final entity = devices.data[index];
                          final name = entity
                              .latest[EntityKeyType.ENTITY_FIELD]
                          ?['name']
                              ?.value ??
                              'Unknown';
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RealtimeScreen(
                                    device: devices.data[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: AutoSizeText(
                                      name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                      minFontSize: 21.0,
                                      maxFontSize: 23.0,
                                      maxLines: 2,
                                    ),
                                  ),
                                  */ /*Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      type,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),*/ /*
                                  Icon(
                                    Icons.transform_rounded,
                                    color: Colors.white,
                                    size: width * .25,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                },
              ),*/