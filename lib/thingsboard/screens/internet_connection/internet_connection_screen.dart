import '../../commons.dart';

part 'internet_connection_controller.dart';

class InternetConnectionScreen extends StatefulWidget {
  const InternetConnectionScreen({super.key});

  @override
  createState() => _InternetConnectionScreen();
}

class _InternetConnectionScreen extends InternetConnectionController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off,
              color: Color(0xFF305680),
              size: 100,
            ),
            Text(
              'Ooops!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.grey.shade800,
              ),
            ),
            Text(
              'Internet Connection not found',
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey.shade800,
              ),
            ),
            Text(
              'Check Connection',
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey.shade800,
              ),
            ),
            Image.asset(
              'assets/images/no_internet.png',
            ),
          ],
        ),
      ),
    );
  }
}
