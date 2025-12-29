import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/notification_permission_service.dart';

part 'notification_permission_provider.g.dart';

@riverpod
NotificationPermissionService notificationPermissionService(
  NotificationPermissionServiceRef ref,
) {
  return NotificationPermissionService();
}

@riverpod
Future<NotificationPermissionStatus> notificationPermissionStatus(
  NotificationPermissionStatusRef ref,
) async {
  final service = ref.watch(notificationPermissionServiceProvider);
  return await service.checkPermission();
}

@riverpod
class NotificationPermission extends _$NotificationPermission {
  @override
  FutureOr<NotificationPermissionStatus> build() async {
    final service = ref.watch(notificationPermissionServiceProvider);
    return await service.checkPermission();
  }

  Future<NotificationPermissionStatus> requestPermission() async {
    final service = ref.read(notificationPermissionServiceProvider);
    final status = await service.requestPermission();
    state = AsyncValue.data(status);
    return status;
  }

  Future<void> refresh() async {
    final service = ref.read(notificationPermissionServiceProvider);
    final status = await service.checkPermission();
    state = AsyncValue.data(status);
  }
}

