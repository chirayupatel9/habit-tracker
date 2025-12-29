import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'services/notification_scheduler_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notifications
  final notifications = FlutterLocalNotificationsPlugin();
  final scheduler = NotificationSchedulerService(notifications);
  await scheduler.initialize();
  
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

