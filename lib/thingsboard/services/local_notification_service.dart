import '../commons.dart';

final notifications = FlutterLocalNotificationsPlugin();
void initializeNotifications() {
  notifications.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveBackgroundNotificationResponse: backgroundHandler,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {

        await notifications.cancel(response.id!);
      }
    },
  );
}

void backgroundHandler(NotificationResponse response) async {
  if (response.payload != null) {
    await notifications.cancel(response.id!);
  }
}

/*
* local notifications handling
* */
Future<void> showNotification({required String title, required String body}) async {
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

  await notifications.show(
    0, // Notification ID
    title, // Title
    body, // Body
    notificationDetails, // Details
  );
}