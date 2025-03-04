import '../commons.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.instance.subscribeToTopic("general");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationOverlay.showNotification(
        message.notification?.title ?? "No Title",
        message.notification?.body ?? "No Body",
      );
    });
  }

  Future<void> disposeNotification() async {
    await _firebaseMessaging.unsubscribeFromTopic("general");
  }
}