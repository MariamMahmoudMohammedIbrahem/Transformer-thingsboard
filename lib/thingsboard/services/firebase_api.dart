import '../commons.dart';


class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      print('Token $fCMToken');
    }
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.instance.subscribeToTopic("general");
    // FirebaseMessaging.onMessageOpenedApp
    // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Show an in-app notification or dialog here
      showNotification(
        title: message.notification?.title ?? "No Title",
        body: message.notification?.body ?? "No Body",
      );
    });

    // Handle messages when the app is opened via notification
    /*FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked: ${message.notification?.title}');
    });*/
  }

  Future<void> disposeNotification() async {
    await _firebaseMessaging.unsubscribeFromTopic("general");
  }
}