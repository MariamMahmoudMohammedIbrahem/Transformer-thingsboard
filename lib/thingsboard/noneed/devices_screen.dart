/*

import '../commons.dart';

class Devices extends StatefulWidget {
  const Devices({super.key});

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  late Future<List<Map<String, dynamic>>> activeDevicesFuture;
  late Future<List<Map<String, dynamic>>> inactiveDevicesFuture;

  @override
  void initState() {
    super.initState();
    fetchDevices();
    // Fetch active and inactive devices
    // activeDevicesFuture = fetchDevices(true);
    // inactiveDevicesFuture = fetchDevices(false);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final controller = Get.put(NavigationController());
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
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(
              0xFF305680,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Devices',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(
                        0xFF305680,
                      ),
                    ),
                  ),
                  Consumer<AppProvider>(
                    builder: (context, toggleProvider, child) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            toggle = !toggle;
                          });
                        },
                        icon: Icon(
                          toggle
                              ? Icons.grid_view_rounded
                              : Icons.list_outlined,
                          color: const Color(0xFF305680),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              FutureBuilder<PageData<EntityData>>(
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
                                      builder: (context) => RealtimeDashboard(
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
                                      builder: (context) => RealtimeDashboard(
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
                                      */
/*Padding(
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
                                  ),*//*

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/
