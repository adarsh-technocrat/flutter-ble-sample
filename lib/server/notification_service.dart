import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._();

  factory NotificationService() => _notificationService;

  NotificationService._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// function to initialise location plugin
  Future initialiseNotificationPlugin() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('app_icon');

    // final IOSInitializationSettings iosInitializationSettings =
    //     IOSInitializationSettings(
    //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    //   requestAlertPermission: false,
    //   requestBadgePermission: false,
    //   requestSoundPermission: false,
    // );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      // iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future onDidReceiveLocalNotification(
    int id,
    String title,
    String body,
    String payload,
  ) async {}

  onSelectNotification(payload) {
    // handle notification tapped logic
    if (payload.isNotEmpty) {
      debugPrint('notification $payload');
    }
  }

  static String channelId = '1';
  static String channelName = 'track';
  static String channelDescription =
      'to display notification for the track in progress';

  // android platform channel specifics
  static AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    channelId, //Required for Android 8.0 or after,
    channelName, //Required for Android 8.0 or after
    importance: Importance.high,
    priority: Priority.high,
    autoCancel: false,
  );
  // platform channel specifics
  NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  void showNotifications(String title, String body, String routeName) {
    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: routeName,
    );
  }

  Future turnOffNotification() async {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}
