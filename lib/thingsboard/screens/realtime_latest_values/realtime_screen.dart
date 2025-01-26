
import 'package:thingsboard_client/thingsboard_client.dart';

import '../../commons.dart';
part 'realtime_controller.dart';

class RealtimeScreen extends StatefulWidget {
  final EntityData device;

  const RealtimeScreen({
    super.key,
    required this.device,
  });

  @override
  createState() => _RealtimeScreen();
}

class _RealtimeScreen extends RealtimeController {
  @override
  Widget build(BuildContext context) {
    final entity = widget.device;
    final name = entity.latest[EntityKeyType.ENTITY_FIELD]?['name']?.value ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        // shadowColor: const Color(0xFF305680),
        // elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          name,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
          Expanded(
            child: ListView(
                children: [
                  const SizedBox(height: 10,),
                  GridView.count(
                    crossAxisCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      DataCard(
                        title: "Voltage Phase 1",
                        value:
                        '${latestValues[keys[0]]}',
                        unit: "V",
                        isAlert:
                        'i',
                      ),
                      DataCard(
                        title: "Voltage Phase 2",
                        value:
                        '${latestValues[keys[1]]}',
                        unit: "V",
                        isAlert:
                        'i',
                      ),
                      DataCard(
                        title: "Voltage Phase 3",
                        value:
                        '${latestValues[keys[2]]}',
                        unit: "V",
                        isAlert:
                        'i',
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  // Current GridView
                  GridView.count(
                    crossAxisCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      DataCard(
                        title: "Current Phase 1",
                        value:
                        '${latestValues[keys[3]]}',
                        unit: "A",
                        isAlert:
                        'i',
                      ),
                      DataCard(
                        title: "Current Phase 2",
                        value:
                        '${latestValues[keys[4]]}',
                        unit: "A",
                        isAlert:
                        'i',
                      ),
                      DataCard(
                        title: "Current Phase 3",
                        value:
                        '${latestValues[keys[5]]}',
                        unit: "A",
                        isAlert:
                        'i',
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: GridView.count(
                      crossAxisCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        DataCard(
                          title: "Oil \nTemperature",
                          value:
                          '${latestValues[keys[6]]}',
                          unit: "°C",
                          isAlert:
                          '${latestValues[keys[7]]}',
                        ),
                        Card(
                          elevation: latestValues[keys[8]] ==
                              'l' ||
                              latestValues[keys[8]] ==
                                  'h'
                              ? 8.0
                              : 2.0,
                          shadowColor: latestValues[keys[8]] ==
                              'l' ||
                              latestValues[keys[8]] ==
                                  'h'
                              ? Colors.red.shade900
                              : Colors.black,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: latestValues[keys[8]] ==
                                  'l' ||
                                  latestValues[keys[8]] ==
                                      'h'
                                  ? Colors.red.shade900
                                  : const Color(0xFF305680),
                              width: latestValues[keys[8]] ==
                                  'l' ||
                                  latestValues[keys[8]] ==
                                      'h'
                                  ? 1.0
                                  : 0.0,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const AutoSizeText(
                                'Oil Level',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF305680),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8.0),
                              if (latestValues[keys[8]] !=
                                  null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (latestValues[keys[8]] !=
                                        'i'
                                    )
                                      Icon(
                                        latestValues[keys[8]] ==
                                            'h'
                                            ? Icons.arrow_upward_rounded
                                            : latestValues[keys[8]] ==
                                            'l'
                                            ? Icons.arrow_downward_rounded
                                            : Icons.person_pin,
                                        color: Colors.red.shade900,
                                        size: 30,
                                      ),
                                    AutoSizeText(
                                      latestValues[keys[8]] == 'i'?'normal':latestValues[keys[8]] == 'l'?'low':'high',
                                      /*style: TextStyle(
                                        // fontSize: 24,
                                        color: Colors.grey.shade800,
                                      ),*/
                                      minFontSize: 16,
                                      maxFontSize: 24,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        Card(
                          elevation: latestValues[keys[9]] ==
                              'l' ||
                              latestValues[keys[9]] ==
                                  'h'
                              ? 8.0
                              : 2.0,
                          shadowColor: latestValues[keys[9]] ==
                              'l' ||
                              latestValues[keys[9]] ==
                                  'h'
                              ? Colors.red.shade900
                              : Colors.black,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: latestValues[keys[9]] ==
                                  'l' ||
                                  latestValues[keys[9]] ==
                                      'h'
                                  ? Colors.red.shade900
                                  : const Color(0xFF305680),
                              width: latestValues[keys[9]] ==
                                  'l' ||
                                  latestValues[keys[9]] ==
                                      'h'
                                  ? 1.0
                                  : 0.0,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          margin:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const AutoSizeText(
                                'Bokhlez\n Sensor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF305680),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8.0),
                              if (latestValues[keys[9]] !=
                                  null)
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    if (latestValues[keys[9]] !=
                                        'i')
                                      Icon(
                                        latestValues[keys[9]] ==
                                            'h'
                                            ? Icons.arrow_upward_rounded
                                            : latestValues[keys[9]] ==
                                            'l'
                                            ? Icons
                                            .arrow_downward_rounded
                                            : Icons.person_pin,
                                        color: Colors.red.shade900,
                                        size: 30,
                                      ),
                                    AutoSizeText(
                                      latestValues[keys[9]] == 'i'?'normal':latestValues[keys[9]] == 'l'?'low':'high',
                                      /*style: TextStyle(
                                        // fontSize: 24,
                                        color: Colors.grey.shade800,
                                      ),*/
                                      minFontSize: 16,
                                      maxFontSize: 24,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
        ],
      ),
      );
  }
}

class DataCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String isAlert;

  const DataCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.isAlert,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isAlert == 'h' || isAlert == 'l' ? 8.0 : 2.0,
      shadowColor:
      isAlert == 'h' || isAlert == 'l' ? Colors.red.shade900 : Colors.black,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isAlert == 'h' || isAlert == 'l'
              ? Colors.red.shade900
              : const Color(0xFF305680),
          width: isAlert == 'h' || isAlert == 'l' ? 1.0 : 0.0,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF305680),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            if (value != 'null')
              Row(
                mainAxisAlignment: isAlert == 'h' || isAlert == 'l'
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  if (isAlert == 'h' || isAlert == 'l')
                    Icon(
                      isAlert == 'h'
                          ? Icons.arrow_upward_rounded
                          : isAlert == 'l'
                          ? Icons.arrow_downward_rounded
                          : null,
                      color: Colors.red.shade900,
                      size: 22,
                    ),
                  AutoSizeText(
                    value,
                    /*style: TextStyle(
                      // fontSize: 24,
                      color: Colors.grey.shade800,
                    ),*/
                    minFontSize: 16,
                    maxFontSize: 24,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  AutoSizeText(unit,
                      style: const TextStyle(
                        // fontSize: 16,
                        color: Colors.grey,
                      ),
                      minFontSize: 12),
                ],
              ),
          ],
        ),
      ),
    );
  }
}