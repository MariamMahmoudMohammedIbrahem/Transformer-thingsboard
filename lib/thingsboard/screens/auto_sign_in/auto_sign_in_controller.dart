part of 'auto_sign_in_screen.dart';

abstract class AutoSignInController extends State<AutoSignInScreen>{

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // bool connected = await checkConnection();
    final autoSignedIn = await autoSign();
    // if(connected) {
      if (autoSignedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const GlobalConnectionChecker(
              child: BottomNavigation(),
            ),
          ),
        );

        /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigation(),
          ),
        );*/
      } else {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const GlobalConnectionChecker(
              child: SignInScreen(),
            ),
          ),
        );
        /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        );*/
      }
    // }
  }
  /*Future<bool> checkConnection () async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult.first == ConnectivityResult.none){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const InternetConnectionScreen(),),);
      return false;
    }
    return true;
  }*/
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
      print(token);
      return true;
    } catch (e) {
      return false;
    }
  }

}