import 'thingsboard/commons.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InternetConnectionService()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const Transformer(),
    ),
  );
}

Future<void> _initializeApp() async {
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
class Transformer extends StatelessWidget {
  const Transformer({super.key});
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