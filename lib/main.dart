import 'package:weather/thingsboard/commons.dart';

/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();
  // HttpOverrides.global = MyHttpOverrides();
  await tbClient.login(LoginRequest('doaamahmed678@gmail.com', 'EoipEgypt'));
  token = tbClient.getJwtToken()!;
  print('token $token');
      runApp(
        ChangeNotifierProvider(
          create: (context) => AppProvider(),
          child: const MyApp(),
        ),
      );
}*/

/*
final notifications = FlutterLocalNotificationsPlugin();
void initializeNotifications() {
  notifications.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveBackgroundNotificationResponse: backgroundHandler,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {

        await notifications.cancel(response.id!);
      }
    },
  );
}
void backgroundHandler(NotificationResponse response) async {
  if (response.payload != null) {
    await notifications.cancel(response.id!);
  }
}*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializeNotifications();
  await _initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InternetConnectionService()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _initializeApp() async {
  initializeNotifications();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context).checkTheme();
    return MaterialApp(
      title: 'Transformer',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<AppProvider>(context).isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const AutoSignInScreen(),
    );
  }
}

class GlobalConnectionChecker extends StatelessWidget {
  final Widget child;

  const GlobalConnectionChecker({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final isConnected = context.watch<InternetConnectionService>().isConnected;

    if (!isConnected) {
      return const InternetConnectionScreen();
    }
    return child;
  }
}