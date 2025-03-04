import '../../commons.dart';

class InternetConnectionScreen extends StatelessWidget {
  const InternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off,
              color: MyColors.blueDark,
              size: 100,
            ),
            Text(
              'Oops!',
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
