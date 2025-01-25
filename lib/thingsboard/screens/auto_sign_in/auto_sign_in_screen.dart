
import '../../commons.dart';

part 'auto_sign_in_controller.dart';

class AutoSignInScreen extends StatefulWidget {
  const AutoSignInScreen({super.key});

  @override
  createState() => _AutoSignInScreen();
}

class _AutoSignInScreen extends AutoSignInController {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 10.0,
              color: Color(0xFF305680),
            ),
          ],
        ),
      ),
    );
  }

}