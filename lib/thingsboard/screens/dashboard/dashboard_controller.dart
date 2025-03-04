
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
    fetchDevicesStream();
  }



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
    } catch (e) {
      throw Exception('Failed to fetch devices: $e');
    }
  }



}
class EntityDataWithStatus {
  final EntityData entityData;
  final String status;

  EntityDataWithStatus({
    required this.entityData,
    required this.status,
  });
}
