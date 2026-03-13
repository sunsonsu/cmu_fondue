/*
 * File: notification_service.dart
 * Description: Centralizes internal push notification management.
 * Responsibilities: Provisions FCM permissions, handles local notification display channels, and maps deep link handlers.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

/// The global handler executed immediately when a silent or background notification arrives.
///
/// This operates asynchronously. It must remain a top-level function.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Background message: ${message.notification?.title}');
  }
}

/// Administers everything related to listening for, routing, and actively presenting alerts.
class NotificationService {
  /// The primary cloud messaging dependency.
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  
  /// The local channels module dependency utilized for active foreground notifications.
  final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();

  /// The active callback registered to handle UI routing upon notification taps.
  Function(String problemId)? _onNotificationTap;

  /// The isolated singleton instance serving the entire application.
  static final NotificationService _instance = NotificationService._internal();
  
  /// Exposes the singular operating [NotificationService] reference.
  factory NotificationService() => _instance;
  
  /// Privately provisions the localized internal objects.
  NotificationService._internal();

  /// Registers an external closure to be fired whenever a user explicitly opens a notification.
  ///
  /// Accepts the [callback] parameter capable of receiving a target identifying string.
  void setNavigationCallback(Function(String problemId) callback) {
    _onNotificationTap = callback;
  }

  /// Connects the entire system and requests active user permission to draw alerts.
  ///
  /// This operates asynchronously. Initializes both FCM and local OS-level channels.
  Future<void> initialize() async {
    await _requestPermission();
    await _initializeLocalNotifications();
    _setupMessageHandlers();
  }

  /// Fetches the unique cloud routing string representing this exact physical device.
  ///
  /// This operates asynchronously. Issues a secondary permissions check and returns the token
  /// or null if the permission state was firmly denied.
  Future<String?> getFcmToken() async {
    NotificationSettings settings = await _fcm.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return await _fcm.getToken();
    }
    return null;
  }

  /// Interrogates the operating system explicitly soliciting privileges.
  Future<NotificationSettings> _requestPermission() async {
    return await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      criticalAlert: false,
      announcement: false,
    );
  }

  /// Installs necessary channels enabling localized alerts when the app is actively open.
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings = 
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings iosSettings = 
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'problem_updates', // channel id
      'Problem Updates', // channel name
      description: 'Notifications for problem status updates',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Attaches all the internal listener scopes mapped to FCM library lifecycle events.
  void _setupMessageHandlers() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    _fcm.getInitialMessage().then((message) {
      if (message != null) {
        _handleMessageOpenedApp(message);
      }
    });
    
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    _fcm.onTokenRefresh.listen((newToken) {
      if (kDebugMode) {
        print('FCM Token refreshed: $newToken');
      }
    });
  }

  /// Reacts properly to messages received while the user is actively staring at the app.
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print('Foreground message: ${message.notification?.title}');
      print('Data: ${message.data}');
    }
    
    if (message.notification != null) {
      await _showLocalNotification(message);
    }
  }

  /// Processes metadata from standard system trays instructing the deep link delegate.
  void _handleMessageOpenedApp(RemoteMessage message) {
    if (kDebugMode) {
      print('Message opened app: ${message.data}');
    }
    
    final problemId = message.data['problemId'];
    if (problemId != null && _onNotificationTap != null) {
      _onNotificationTap!(problemId);
    }
  }

  /// Bridges local notification interactions back directly into the deep link delegate.
  void _onNotificationTapped(NotificationResponse response) {
    if (kDebugMode) {
      print('Local notification tapped: ${response.payload}');
    }
    
    if (response.payload != null && _onNotificationTap != null) {
      _onNotificationTap!(response.payload!);
    }
  }

  /// Constructs an artificial system-level heads up notification for foreground consumption.
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = 
        AndroidNotificationDetails(
      'problem_updates',
      'Problem Updates',
      channelDescription: 'Notifications for problem status updates',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'การแจ้งเตือน',
      message.notification?.body ?? '',
      details,
      payload: message.data['problemId']?.toString(),
    );
  }

  /// Connects the device directly to a broadcast mechanism via the [topic].
  Future<void> subscribeToTopic(String topic) async {
    await _fcm.subscribeToTopic(topic);
    if (kDebugMode) {
      print('Subscribed to topic: $topic');
    }
  }

  /// Removes the device successfully from a specific broad distribution [topic].
  Future<void> unsubscribeFromTopic(String topic) async {
    await _fcm.unsubscribeFromTopic(topic);
    if (kDebugMode) {
      print('Unsubscribed from topic: $topic');
    }
  }

  /// Scraps the remote FCM identifier entirely shutting down messaging functionally.
  ///
  /// Side effects:
  /// Invalidates cloud communication entirely forcing a re-authorization sequence later.
  Future<void> deleteToken() async {
    await _fcm.deleteToken();
    if (kDebugMode) {
      print('FCM Token deleted');
    }
  }
}