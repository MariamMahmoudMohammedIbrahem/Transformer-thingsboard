
part of 'dashboard_screen.dart';

abstract class DashboardController extends State<DashboardScreen> {

  late Future<List<Map<String, dynamic>>> activeDevicesFuture;
  late Future<List<Map<String, dynamic>>> inactiveDevicesFuture;
  final entityFilter = EntityTypeFilter(entityType: EntityType.DEVICE);

  final List<EntityKey> deviceFields = [
    EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'name'),
    EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'type'),
    EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'createdTime')
  ];

  // Define the key to fetch the 'active' status
  var activeKey = EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active');

  late EntityDataQuery devicesQuery;
  bool toggle = true;

  @override
  void initState() {
    super.initState();
    /*var connectivityResult = Connectivity().onConnectivityChanged;
    connectivityResult.listen((event) {
      print('inside initState dashboard controller $event');
      if(event.first == ConnectivityResult.none){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const InternetConnectionScreen(),),);
      }
    });*/
    fetchDevicesStream();
  }
  // Future<void> gettingDevicesCount () async{
  //   // Create entity filter to get all devices
  //   var entityFilter = EntityTypeFilter(entityType: EntityType.DEVICE);
  //
  //   // Create entity count query with provided filter
  //   var devicesQuery = EntityCountQuery(entityFilter: entityFilter);
  //   var activeDeviceKeyFilter = KeyFilter(
  //       key: EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active'),
  //       valueType: EntityKeyValueType.BOOLEAN,
  //       predicate: BooleanFilterPredicate(
  //           operation: BooleanOperation.EQUAL,
  //           value: FilterPredicateValue(true)));
  //
  //   devicesQuery.keyFilters = [activeDeviceKeyFilter];
  //
  //   // Execute entity count query and get total active devices count
  //   var activeDevicesCount = await tbClient.getEntityQueryService().countEntitiesByQuery(devicesQuery);
  //
  //   print('Active devices:$activeDevicesCount');
  //
  //   // Set key filter to existing query to get only inactive devices
  //   var inactiveDeviceKeyFilter = KeyFilter(
  //   key: EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active'),
  //   valueType: EntityKeyValueType.BOOLEAN,
  //   predicate: BooleanFilterPredicate(
  //   operation: BooleanOperation.EQUAL,
  //   value: FilterPredicateValue(false)));
  //   devicesQuery.keyFilters = [inactiveDeviceKeyFilter];
  //
  //   // Execute entity count query and get total inactive devices count
  //   var inactiveDevicesCount =
  //   await tbClient.getEntityQueryService().countEntitiesByQuery(devicesQuery);
  //   print('Inactive devices: $inactiveDevicesCount');
  // }
//device name
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
///trying to get the devices along with their status id + status
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

///trying to get name + status
  Stream<PageData<EntityData>> fetchDevicesStream() async* {
    try {

      // Define the device query
      devicesQuery = EntityDataQuery(
        entityFilter: entityFilter,
        keyFilters: [], // No filters to retrieve all devices
        entityFields: deviceFields, // Fetch device name
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
        devices = await tbClient
            .getEntityQueryService()
            .findEntityDataByQuery(devicesQuery);

        yield devices;

        // Delay before the next fetch
        await Future.delayed(const Duration(seconds: 2));
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Error: $e');
        print('Stack: $s');
      }
    }
  }

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

}
class EntityDataWithStatus {
  final EntityData entityData;
  final String status;

  EntityDataWithStatus({
    required this.entityData,
    required this.status,
  });
}
