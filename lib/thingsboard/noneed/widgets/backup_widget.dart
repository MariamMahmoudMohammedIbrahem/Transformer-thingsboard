///*constants.dart**
// const thingsBoardApiEndpoint = 'http://192.168.0.210:8081';
// Global variables
// final HttpOverrides httpOverrides = MyHttpOverrides();
// late ThingsboardClient tbClient;
// int? inactiveDevicesCount;

// const String email = 'mariam.mahmoud2811@gmail.com';
// const String password = 'mariamEoipEgypt';
// const String password = 'tenantEoipEgypt';
// var inactiveDevicesCount = 0;
// List<String> deviceNames = [];
/*final activeDeviceKeyFilter = KeyFilter(
  key: EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active'),
  valueType: EntityKeyValueType.BOOLEAN,
  predicate: BooleanFilterPredicate(
      operation: BooleanOperation.EQUAL, value: FilterPredicateValue(true)),
);*/
/*
final inactiveDeviceKeyFilter = KeyFilter(
  key: EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active'),
  valueType: EntityKeyValueType.BOOLEAN,
  predicate: BooleanFilterPredicate(
      operation: BooleanOperation.EQUAL, value: FilterPredicateValue(false)),
);*/
/*final List<EntityKey> deviceAttributes = [
  EntityKey(type: EntityKeyType.ATTRIBUTE, key: 'active')
];*/

library;
///*main.dart**
/*Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  try {
    // Initialize ThingsBoard client
    tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // Perform login
    await tbClient.login(LoginRequest(email, password));

    // print('isAuthenticated=${tbClient.isAuthenticated()}');
    // print('authUser: ${tbClient.getAuthUser()}');

    // Get user details
    // var currentUserDetails = await tbClient.getUserService().getUser();
    // print('currentUserDetails: $currentUserDetails');

    // Initialize the device query
    devicesQuery = EntityDataQuery(
      entityFilter: entityFilter,
      keyFilters: [inactiveDeviceKeyFilter],
      entityFields: deviceFields,
      latestValues: deviceAttributes,
      pageLink: EntityDataPageLink(
          pageSize: 10,
          sortOrder: EntityDataSortOrder(
              key: EntityKey(
                  type: EntityKeyType.ENTITY_FIELD, key: 'createdTime'),
              direction: EntityDataSortOrderDirection.DESC)),
    );

    do {
      devices = await tbClient
          .getEntityQueryService()
          .findEntityDataByQuery(devicesQuery);
      print('Active devices entities data: $devices');
      devices.data.forEach((device) {
        print(
            'id: ${device.entityId.id}, createdTime: ${device.createdTime}, name: ${device.field('name')!}, type: ${device.field('type')!}, active: ${device.attribute('active')}');
        deviceNames.add(device.field('name')!);
      });
      devicesQuery = devicesQuery.next();
    } while (devices.hasNext);
    print('devices names $deviceNames');
    // inactiveDevicesCount = await tbClient
    //     .getEntityQueryService()
    //     .countEntitiesByQuery(devicesQuery);
    // print('Inactive devices: $inactiveDevicesCount');
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }

  // print('isAuthenticated=${tbClient.isAuthenticated()}');
  runApp(const MyApp());
}*/

/*Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  try {
    tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    await tbClient.login(LoginRequest(email, password));

    devicesQuery = EntityDataQuery(
      entityFilter: entityFilter,
      keyFilters: [inactiveDeviceKeyFilter],
      entityFields: deviceFields,
      latestValues: deviceAttributes,
      pageLink: EntityDataPageLink(
          pageSize: 10,
          sortOrder: EntityDataSortOrder(
              key: EntityKey(
                  type: EntityKeyType.ENTITY_FIELD, key: 'createdTime'),
              direction: EntityDataSortOrderDirection.DESC)),
    );

    do {
      devices = await tbClient
          .getEntityQueryService()
          .findEntityDataByQuery(devicesQuery);
      print('Active devices entities data: $devices');
      devices.data.forEach((device) {
        var name = device.field('name');
        if (name != null) {
          deviceNames.add(name);
        }
        print(
            'id: ${device.entityId.id}, createdTime: ${device.createdTime}, name: ${device.field('name')}, type: ${device.field('type')}, active: ${device.attribute('active')}');
      });
      devicesQuery = devicesQuery.next();
    } while (devices.hasNext);

    // Print the collected device names
    print('Device Names: $deviceNames');
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }

  runApp(const MyApp());
}*/

/*Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  try {
    tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    await tbClient.login(LoginRequest(email, password));

    // Fetch devices with telemetry data included
    devicesQuery = EntityDataQuery(
      entityFilter: entityFilter,
      keyFilters: [], // Add specific filters if needed
      entityFields: deviceFields,
      latestValues: [
        EntityKey(type: EntityKeyType.TIME_SERIES, key: 'bokhlez_status1'),
        EntityKey(type: EntityKeyType.TIME_SERIES, key: 'amb_temp'),
      ],
      pageLink: EntityDataPageLink(
        pageSize: 10,
        sortOrder: EntityDataSortOrder(
          key: EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'createdTime'),
          direction: EntityDataSortOrderDirection.DESC,
        ),
      ),
    );

    // Fetch devices and process
    devices = await tbClient.getEntityQueryService().findEntityDataByQuery(devicesQuery);

    if (devices.data.isNotEmpty) {
      // First device
      var firstDevice = devices.data.first;
      var firstDeviceId = firstDevice.entityId.id;

      print('First Device ID: $firstDeviceId');
      print('Name: ${firstDevice.field('name')}');
      print('Type: ${firstDevice.field('type')}');

      // Fetch telemetry from latestValues
      var telemetryKeys = firstDevice.latest[EntityKeyType.TIME_SERIES];
      if (telemetryKeys != null) {
        telemetryKeys.forEach((key, tsValue) {
          print('Telemetry Key: $key, Latest Value: ${tsValue.value}');
        });
      } else {
        print('No telemetry data available for the first device.');
      }
    } else {
      print('No devices found.');
    }
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }

  runApp(const MyApp());
}*/


/*Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  try {
    tbClient = ThingsboardClient(thingsBoardApiEndpoint);

    // Login to ThingsBoard
    await tbClient.login(LoginRequest(email, password));

    // Fetch devices
    devicesQuery = EntityDataQuery(
      entityFilter: entityFilter,
      keyFilters: [], // Add specific filters if needed
      entityFields: deviceFields,
      latestValues: [
        EntityKey(type: EntityKeyType.TIME_SERIES, key: 'bokhlez_status1'),
        EntityKey(type: EntityKeyType.TIME_SERIES, key: 'amb_temp'),
      ],
      pageLink: EntityDataPageLink(
        pageSize: 10,
        sortOrder: EntityDataSortOrder(
          key: EntityKey(type: EntityKeyType.ENTITY_FIELD, key: 'createdTime'),
          direction: EntityDataSortOrderDirection.DESC,
        ),
      ),
    );

    devices = await tbClient.getEntityQueryService().findEntityDataByQuery(devicesQuery);

    if (devices.data.isNotEmpty) {
      // First device
      var firstDevice = devices.data[1];
      var firstDeviceId = firstDevice.entityId.id;

      print('First Device ID: $firstDeviceId');
      print('Name: ${firstDevice.field('name')}');
      print('Type: ${firstDevice.field('type')}');

      // Define the time range for the last 7 days
      final endTime = DateTime.now().millisecondsSinceEpoch;
      final startTime = DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch;

      // Fetch telemetry data using REST API
      var telemetryKeys = ['bokhlez_status1', 'amb_temp'];
      var telemetryData = await fetchTelemetryData(
        firstDeviceId!,
        telemetryKeys,
        startTime,
        endTime,
      );

      // Print telemetry data
      telemetryData.forEach((key, tsValues) {
        print('Telemetry Key: $key');
        tsValues.forEach((tsValue) {
          print('Timestamp: ${tsValue['ts']}, Value: ${tsValue['value']}');
        });
      });
    } else {
      print('No devices found.');
    }
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
  }

  runApp(const MyApp());
}*/

///*functions.dart**

/*
import '../services/thingsboard_client.dart';
Future<void> addCustomer(String title) async {
  try {
    final customer = Customer(title);
    final createdCustomer = await tbClient.getCustomerService().saveCustomer(customer);
    print('Customer created successfully: ${createdCustomer.id}');
  } catch (e) {
    print('Failed to create customer: $e');
  }
}
*/

///*devices_screen.dart**


/*Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDeviceList(Future<List<Map<String, dynamic>>> devicesFuture) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: devicesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No devices found.'));
        }
        var devices = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: devices.length,
          itemBuilder: (context, index) {
            var device = devices[index];
            return Card(
              child: ListTile(
                leading: const Icon(
                  Icons.devices,
                  color: Colors.blue,
                ),
                title: Text(device['name']),
                subtitle: Text(
                  'Type: ${device['type']}\nCreated: ${device['createdTime']}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Navigate to device details screen
                  *//*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeviceDetailsScreen(device: device),
                    ),
                  );*//*
                },
              ),
            );
          },
        );
      },
    );
  }*/

/*_buildSectionHeader('Active Devices'),
              _buildDeviceList(activeDevicesFuture),
              _buildSectionHeader('Inactive Devices'),
              _buildDeviceList(inactiveDevicesFuture),*/
///*repatcha**
/*
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecaptchaScreen extends StatefulWidget {
  const RecaptchaScreen({super.key});

  @override
  _RecaptchaScreenState createState() => _RecaptchaScreenState();
}

class _RecaptchaScreenState extends State<RecaptchaScreen> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("reCAPTCHA Verification")),
      body: WebView(
        initialUrl: 'https://www.google.com/recaptcha/api2/demo',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        javascriptChannels: {
          JavascriptChannel(
            name: 'RecaptchaResponse',
            onMessageReceived: (message) {
              print('Recaptcha Token: ${message.message}');
            },
          ),
        },
      ),
    );
  }
}
class WebViewTest extends StatelessWidget {
  const WebViewTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('InAppWebView Test')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse("https://flutter.dev")),
      ),
    );
  }
}*/

///*customers_screen.dart**

/*// Fetch customers from ThingsBoard
  Future<void> fetchCustomers() async {
    setState(() => isLoading = true);
    final url = Uri.parse('https://demo.thingsboard.io/customers?pageSize=10&page=0');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        customers = List<Map<String, dynamic>>.from(data['data']);
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      print('Error fetching customers: ${response.body}');
    }
  }

  // Add a new customer to ThingsBoard
  Future<void> addCustomer(String title) async {
    final url = Uri.parse('https://demo.thingsboard.io/customers');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'additionalInfo': {'description': 'Added from mobile app'}
      }),
    );

    if (response.statusCode == 200) {
      print('Customer added successfully: ${response.body}');
      fetchCustomers(); // Refresh the customer list
    } else {
      print('Failed to add customer: ${response.body}');
    }
  }

  // Show a dialog to add a new customer
  void showAddCustomerDialog() {
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Customer'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Customer Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text.trim();
                if (title.isNotEmpty) {
                  addCustomer(title);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }*/
/*Future<void> addCustomer(String title) async {
    try {
      final customer = Customer(title);
      final createdCustomer =
          await tbClient.getCustomerService().saveCustomer(customer);
      print('Customer created successfully: ${createdCustomer.id}');
      fetchCustomers(); // Refresh the customer list
    } catch (e) {
      print('Failed to create customer: $e');
    }
  }*/

/*void showAddCustomerDialog() {
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Customer'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Customer Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text.trim();
                if (title.isNotEmpty) {
                  addCustomer(title);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }*/

///*sign_up_screen.dart**
/*class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text:'mariam.mahmoud2811@gmail.com');
  final _passwordController = TextEditingController(text:'mariamPassword');
  final _firstNameController = TextEditingController(text: 'mariam');
  final _lastNameController = TextEditingController(text:'mahmoud');

  bool _isLoading = false;

  Future<void> signup() async {
    setState(() {
      _isLoading = true;
    });

    const String signupUrl = "http://demo.thingsboard.io/api/noauth/signup";

    final Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
    };

    try {
      final response = await http.post(
        Uri.parse(signupUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Successful signup
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup successful!")),
        );
      } else {
        // Handle error
        print('${response.body}, ${response.statusCode}');
        final responseBody = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${responseBody['message'] ?? 'Signup failed'}")),
        );
      }
    } catch (e) {
      // Handle connection errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Network error: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup to ThingsBoard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: "First Name"),
                validator: (value) => value == null || value.isEmpty ? "First Name is required" : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: "Last Name"),
                validator: (value) => value == null || value.isEmpty ? "Last Name is required" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || !value.contains("@") ? "Enter a valid email" : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) => value == null || value.length < 6 ? "Password must be at least 6 characters" : null,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    signup();
                  }
                },
                child: const Text("Signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
