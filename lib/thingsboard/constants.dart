
import 'commons.dart';

late String thingsBoardApiEndpoint;

var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

Map<String, Map<int, dynamic>> telemetryData = {};

late PageData<EntityData> devices;

var token = '';

///*sign_in_screen.dart**

late String emailUser;

late String password;


List<String> keys = ['v1','v2','v3','i1','i2','i3','tv','ts','os','bs'];

bool notificationEnable = true;