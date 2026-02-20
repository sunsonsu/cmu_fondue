// Komsan
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

// Top-level function สำหรับ background handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Background message: ${message.notification?.title}');
  }
}

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();

  // Singleton pattern
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // Initialize notification service
  Future<void> initialize() async {
    // Request permission
    await _requestPermission();
    
    // Initialize local notifications
    await _initializeLocalNotifications();
    
    // Setup message handlers
    _setupMessageHandlers();
  }

  Future<String?> getFcmToken() async {
    NotificationSettings settings = await _fcm.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return await _fcm.getToken();
    }
    return null;
  }

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

  // Initialize local notifications สำหรับแสดงเมื่อ app อยู่ foreground
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

    // สร้าง notification channel สำหรับ Android
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

  // Setup message handlers
  void _setupMessageHandlers() {
    // Background handler (ต้องอยู่ top-level)
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    
    // Foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // เมื่อกดที่ notification ขณะ app terminated
    _fcm.getInitialMessage().then((message) {
      if (message != null) {
        _handleMessageOpenedApp(message);
      }
    });
    
    // เมื่อกดที่ notification ขณะ app อยู่ background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Listen for token refresh
    _fcm.onTokenRefresh.listen((newToken) {
      if (kDebugMode) {
        print('FCM Token refreshed: $newToken');
      }
      // TODO: อัปเดต token ในฐานข้อมูล
    });
  }

  // Handle foreground message - แสดง notification เอง
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print('Foreground message: ${message.notification?.title}');
      print('Data: ${message.data}');
    }
    
    if (message.notification != null) {
      await _showLocalNotification(message);
    }
  }

  // Handle เมื่อกดที่ notification
  void _handleMessageOpenedApp(RemoteMessage message) {
    if (kDebugMode) {
      print('Message opened app: ${message.data}');
    }
    
    // TODO: Navigate ไปหน้า Problem Detail
    final problemId = message.data['problemId'];
    if (problemId != null) {
      debugPrint('Navigate to problem: $problemId');
    }
  }

  // Handle เมื่อกดที่ local notification
  void _onNotificationTapped(NotificationResponse response) {
    if (kDebugMode) {
      print('Local notification tapped: ${response.payload}');
    }
    
    // TODO: Navigate ไปหน้า Problem Detail
    if (response.payload != null) {
      debugPrint('Navigate to problem: ${response.payload}');
    }
  }

  // Show local notification
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

  // Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    await _fcm.subscribeToTopic(topic);
    if (kDebugMode) {
      print('Subscribed to topic: $topic');
    }
  }

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _fcm.unsubscribeFromTopic(topic);
    if (kDebugMode) {
      print('Unsubscribed from topic: $topic');
    }
  }

  // Delete FCM token
  Future<void> deleteToken() async {
    await _fcm.deleteToken();
    if (kDebugMode) {
      print('FCM Token deleted');
    }
  }
}