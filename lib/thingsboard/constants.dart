
import 'commons.dart';

// String thingsBoardApiEndpoint = 'http://192.168.0.112:8081';
String thingsBoardApiEndpoint = 'https://demo.thingsboard.io';

var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

Map<String, Map<int, dynamic>> telemetryData = {};


late PageData<EntityData> devices;
var token = '';


///*main.dart**
// const String email = 'doaamahmed678@gmail.com';
// const String password = 'EoipEgypt';
// Filters and Queries


///*sign_in_screen.dart**

late String emailUser;
late String password;


List<String> keys = ['v1','v2','v3','i1','i2','i3','tv','ts','os','bs'];