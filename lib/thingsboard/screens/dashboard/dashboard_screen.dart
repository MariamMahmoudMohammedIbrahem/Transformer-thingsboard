import '../../commons.dart';
part 'dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  createState() => _DashboardScreen();
}

class _DashboardScreen extends DashboardController {
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
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
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
                      color: MyColors.blueDark,
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
                          color: MyColors.blueDark,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              StreamBuilder<PageData<EntityData>>(
                stream: fetchDevicesStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
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
                              final status = entity
                                      .latest[EntityKeyType.ATTRIBUTE]
                                          ?['active']
                                      ?.value == 'true' ?'active':
                              'inactive';
                              return ListTile(
                                leading: const Icon(
                                  Icons.transform_rounded,
                                  color: MyColors.blueDark,
                                ),
                                title: Text(
                                  name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.blueDark,
                                  ),
                                ),
                                subtitle: Text(
                                  type,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                                trailing: Text(
                                  status,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GlobalConnectionChecker(
                                        child: RealtimeScreen(
                                          device: devices.data[index],
                                        ),
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
                                onTap: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GlobalConnectionChecker(
                                        child: RealtimeScreen(
                                          device: devices.data[index],
                                        ),
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
                                      Icon(
                                        Icons.transform_rounded,
                                        color: Colors.white,
                                        size: width * .25,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
