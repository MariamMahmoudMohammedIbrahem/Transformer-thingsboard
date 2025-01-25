/*

import '../commons.dart';

class RealtimeDashboard extends StatefulWidget {
  final EntityData device;

  const RealtimeDashboard({
    super.key,
    required this.device,
  });

  @override
  State<RealtimeDashboard> createState() => _RealtimeDashboard();
}

class _RealtimeDashboard extends State<RealtimeDashboard> {
  late Map<String, dynamic> timeSeriesData;
  late Map<String, TsValue> timeSeries;

  @override
  void initState() {
    super.initState();
    timeSeries = widget.device.latest[EntityKeyType.TIME_SERIES] ?? {};
    timeSeriesData = extractTimeSeries(timeSeries);
  }

  @override
  Widget build(BuildContext context) {
    final entity = widget.device;

    final name = entity.latest[EntityKeyType.ENTITY_FIELD]?['name']?.value ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color(0xFF305680),
        elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: AutoSizeText(
          name,
        ),
        titleTextStyle: const TextStyle(
          color: Color(0xFF305680),
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView(
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
                '${timeSeries[keys[0]]?.value}',
                unit: "V",
                isAlert:
                'i',
              ),
              DataCard(
                title: "Voltage Phase 2",
                value:
                '${timeSeries[keys[1]]?.value}',
                unit: "V",
                isAlert:
                'i',
              ),
              DataCard(
                title: "Voltage Phase 3",
                value:
                '${timeSeries[keys[2]]?.value}',
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
                '${timeSeries[keys[3]]?.value}',
                unit: "A",
                isAlert:
                'i',
              ),
              DataCard(
                title: "Current Phase 2",
                value:
                '${timeSeries[keys[4]]?.value}',
                unit: "A",
                isAlert:
                'i',
              ),
              DataCard(
                title: "Current Phase 3",
                value:
                '${timeSeries[keys[5]]?.value}',
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
                  '${timeSeries[keys[6]]?.value}',
                  unit: "°C",
                  isAlert:
                  '${timeSeries[keys[7]]?.value}',
                ),
                Card(
                  elevation: timeSeries[keys[8]]?.value ==
                      'l' ||
                      timeSeries[keys[8]]?.value ==
                          'h'
                      ? 8.0
                      : 2.0,
                  shadowColor: timeSeries[keys[8]]?.value ==
                      'l' ||
                      timeSeries[keys[8]]?.value ==
                          'h'
                      ? Colors.red.shade900
                      : Colors.black,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: timeSeries[keys[8]]?.value ==
                          'l' ||
                          timeSeries[keys[8]]?.value ==
                              'h'
                          ? Colors.red.shade900
                          : const Color(0xFF305680),
                      width: timeSeries[keys[8]]?.value ==
                          'l' ||
                          timeSeries[keys[8]]?.value ==
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
                      if (timeSeries[keys[8]]?.value !=
                          null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (timeSeries[keys[8]]?.value !=
                                'i'
                            )
                              Icon(
                                timeSeries[keys[8]]?.value ==
                                    'h'
                                    ? Icons.arrow_upward_rounded
                                    : timeSeries[keys[8]]?.value ==
                                    'l'
                                    ? Icons.arrow_downward_rounded
                                    : Icons.person_pin,
                                color: Colors.red.shade900,
                                size: 30,
                              ),
                            AutoSizeText(
                              timeSeries[keys[8]]?.value == 'i'?'normal':timeSeries[keys[8]]?.value == 'l'?'low':'high',
                              style: TextStyle(
                                // fontSize: 24,
                                color: Colors.grey.shade800,
                              ),
                              minFontSize: 16,
                              maxFontSize: 24,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                Card(
                  elevation: timeSeries[keys[9]]?.value ==
                      'l' ||
                      timeSeries[keys[9]]?.value ==
                          'h'
                      ? 8.0
                      : 2.0,
                  shadowColor: timeSeries[keys[9]]?.value ==
                      'l' ||
                      timeSeries[keys[9]]?.value ==
                          'h'
                      ? Colors.red.shade900
                      : Colors.black,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: timeSeries[keys[9]]?.value ==
                          'l' ||
                          timeSeries[keys[9]]?.value ==
                              'h'
                          ? Colors.red.shade900
                          : const Color(0xFF305680),
                      width: timeSeries[keys[9]]?.value ==
                          'l' ||
                          timeSeries[keys[9]]?.value ==
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
                      if (timeSeries[keys[9]]?.value !=
                          null)
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            if (timeSeries[keys[9]]?.value !=
                                'i')
                              Icon(
                                timeSeries[keys[9]]?.value ==
                                    'h'
                                    ? Icons.arrow_upward_rounded
                                    : timeSeries[keys[9]]?.value ==
                                    'l'
                                    ? Icons
                                    .arrow_downward_rounded
                                    : Icons.person_pin,
                                color: Colors.red.shade900,
                                size: 30,
                              ),
                            AutoSizeText(
                              timeSeries[keys[9]]?.value == 'i'?'normal':timeSeries[keys[9]]?.value == 'l'?'low':'high',
                              style: TextStyle(
                                // fontSize: 24,
                                color: Colors.grey.shade800,
                              ),
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
                    style: TextStyle(
                      // fontSize: 24,
                      color: Colors.grey.shade800,
                    ),
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
*/
