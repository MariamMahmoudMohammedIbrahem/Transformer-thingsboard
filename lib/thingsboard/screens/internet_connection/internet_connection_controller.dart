part of 'internet_connection_screen.dart';

abstract class InternetConnectionController
    extends State<InternetConnectionScreen> {

  @override
  void initState() {
    // checkConnection();
    super.initState();
  }

  /*void checkConnection () async{
    var connectivityResult = Connectivity().onConnectivityChanged;
    connectivityResult.listen((event) {
      print('event $event');
      if(event.first != ConnectivityResult.none){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const AutoSignInScreen(),),);
      }
    });
  }*/
  @override
  void dispose() {

    super.dispose();
  }
}