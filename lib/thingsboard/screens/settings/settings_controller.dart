part of 'settings_screen.dart';

abstract class SettingsController extends State<SettingsScreen> {

 void controlNotification () {
   if(notificationEnable) {
     setState(() {
       notificationEnable = false;
     });
     FirebaseApi().disposeNotification();
   } else {
     setState(() {
       notificationEnable = true;
     });
     FirebaseApi().initNotification();
   }
 }

 void logOut () {
   try {
     tbClient.logout();
     FirebaseApi().disposeNotification();
     emailUser = '';
     password = '';
     Provider.of<AppProvider>(context, listen: false).setFirstTime('', '');
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const SignInScreen(),), (route) => false);
   }
   catch(e){
     throw Exception("Failed to logout $e");
   }
 }
}