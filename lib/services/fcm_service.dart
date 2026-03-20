import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FcmService {
  FcmService._();

  static final FcmService instance = FcmService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final ValueNotifier<NotificationSettings?> permissionSettings =
      ValueNotifier<NotificationSettings?>(null);
  final ValueNotifier<String?> token = ValueNotifier<String?>(null);
  final ValueNotifier<RemoteMessage?> latestMessage =
      ValueNotifier<RemoteMessage?>(null);
  final ValueNotifier<String> launchContext =
      ValueNotifier<String>('Waiting for a push event...');

  bool _isInitialized = false;
  StreamSubscription<String>? _tokenRefreshSubscription;
  StreamSubscription<RemoteMessage>? _foregroundSubscription;
  StreamSubscription<RemoteMessage>? _openedAppSubscription;

  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    _isInitialized = true;

    await _messaging.setAutoInitEnabled(true);

    permissionSettings.value = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _messaging.subscribeToTopic('all_staff');

    token.value = await _messaging.getToken();

    _tokenRefreshSubscription = _messaging.onTokenRefresh.listen((newToken) {
      token.value = newToken;
    });

    _foregroundSubscription = FirebaseMessaging.onMessage.listen((message) {
      latestMessage.value = message;
      launchContext.value = 'Foreground message received';
    });

    _openedAppSubscription = FirebaseMessaging.onMessageOpenedApp.listen((message) {
      latestMessage.value = message;
      launchContext.value = 'Opened app from background notification tap';
    });

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      latestMessage.value = initialMessage;
      launchContext.value = 'Opened app from terminated notification tap';
    }
  }

  Future<void> refreshToken() async {
    await _messaging.deleteToken();
    token.value = await _messaging.getToken();
  }

  String permissionStatusLabel() {
    final settings = permissionSettings.value;

    if (settings == null) {
      return 'Unknown';
    }

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        return 'Authorized';
      case AuthorizationStatus.denied:
        return 'Denied';
      case AuthorizationStatus.notDetermined:
        return 'Not determined';
      case AuthorizationStatus.provisional:
        return 'Provisional';
    }
  }

  @visibleForTesting
  Future<void> dispose() async {
    await _tokenRefreshSubscription?.cancel();
    await _foregroundSubscription?.cancel();
    await _openedAppSubscription?.cancel();
  }
}
