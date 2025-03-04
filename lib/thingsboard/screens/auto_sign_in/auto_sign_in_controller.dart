part of 'auto_sign_in_screen.dart';

abstract class AutoSignInController extends State<AutoSignInScreen>{

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final autoSignedIn = await autoSign();
    if (autoSignedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GlobalConnectionChecker(
            child: BottomNavigation(),
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GlobalConnectionChecker(
            child: SignInScreen(),
          ),
        ),
      );
    }
  }
  Future<bool> autoSign() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';
    thingsBoardApiEndpoint = prefs.getString('api_end_point')??'https://demo.thingsboard.io';

    if (email.isEmpty || password.isEmpty) {
      return false;
    }

    try {
      await tbClient.login(LoginRequest(email, password));

      await FirebaseApi().initNotification();
      token = tbClient.getJwtToken()!;
      return true;
    } catch (e) {
      return false;
    }
  }

}