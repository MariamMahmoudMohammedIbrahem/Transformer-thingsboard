import '../commons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('Body: ${message.notification?.body}');
//   print('Payload: ${message.data}');
// }
Future<void> _showNotification({required String title, required String body}) async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'high_importance_channel', // ID of the notification channel
    'High Importance Notifications', // Name of the channel
    channelDescription: 'This channel is used for important notifications.', // Description
    importance: Importance.high,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title, // Title
    body, // Body
    notificationDetails, // Details
  );
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token $fCMToken');
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.instance.subscribeToTopic("general");
    ///TODO: manage what happens when press on the notification
    // FirebaseMessaging.onMessageOpenedApp
    // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.title}');
      // Show an in-app notification or dialog here
      _showNotification(
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