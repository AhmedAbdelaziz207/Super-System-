import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  static const String _androidChannelId = 'super_system_channel';
  static const String _androidChannelName = 'Super System';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    tz.initializeTimeZones();
    await _initLocalNotifications();
    await _requestPermissions();
    await _setupFCMHandlers();
      try {
  final token = await _firebaseMessaging.getToken();
  debugPrint('FCM Token: $token');
} on Exception catch (e) {
         debugPrint('Error getting FCM Token: $e');
}
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    await _localNotifications.initialize(settings);

    if (Platform.isAndroid) {
      await Permission.notification.request();
    }
  }

  NotificationDetails _notificationDetails() {
    const androidDetails = AndroidNotificationDetails(
      _androidChannelId,
      _androidChannelName,
      importance: Importance.max,
      priority: Priority.high,
    );

    return const NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      debugPrint('iOS permission: ${settings.authorizationStatus}');
    } else if (Platform.isAndroid) {
      if (await Permission.notification.request().isGranted) {
        debugPrint('Android notification permission granted');
      } else {
        debugPrint('Notification permission denied');
      }
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    debugPrint('Background FCM message: ${message.messageId}');
  }

  Future<void> _setupFCMHandlers() async {
    _firebaseMessaging.onTokenRefresh.listen((token) {
      debugPrint('FCM Token refreshed: $token');
      // TODO: Send token to server
    });

    try {
  final token = await _firebaseMessaging.getToken();
  debugPrint('FCM Token: $token');
} on Exception catch (e) {
         debugPrint('Error getting FCM Token: $e');
}

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground FCM Message: ${message.data}');
    if (message.notification != null) {
      showLocalNotification(
        id: message.hashCode,
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
      );
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('Notification Tapped: ${message.data}');
    // TODO: Navigate based on message data
  }

  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
    int id = 0,
  }) async {
    await _localNotifications.show(
      id,
      title,
      body,
      _notificationDetails(),
      payload: payload,
    );
  }

  Future<void> showScheduledNotification({
    required String title,
    required String body,
    required Duration delay,
    int id = 1,
  }) async {
    final scheduleTime = DateTime.now().add(delay);

    await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduleTime, tz.local),
      _notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.inexact,
    );
  }

  Future<void> showRepeatedNotification({
    required String title,
    required String body,
    Duration interval = const Duration(days: 1),
    int id = 2,
  }) async {
    final repeatInterval = interval.inDays >= 1
        ? RepeatInterval.daily
        : RepeatInterval.everyMinute;

    await _localNotifications.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexact,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
