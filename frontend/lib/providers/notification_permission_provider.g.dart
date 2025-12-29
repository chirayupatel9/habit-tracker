// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_permission_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationPermissionServiceHash() =>
    r'6307f962256439b796c1f389843c62f268e411a6';

/// See also [notificationPermissionService].
@ProviderFor(notificationPermissionService)
final notificationPermissionServiceProvider =
    AutoDisposeProvider<NotificationPermissionService>.internal(
  notificationPermissionService,
  name: r'notificationPermissionServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationPermissionServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationPermissionServiceRef
    = AutoDisposeProviderRef<NotificationPermissionService>;
String _$notificationPermissionStatusHash() =>
    r'2c4c5c2b44c8f617d9cf4e2b360fb326e1b625dd';

/// See also [notificationPermissionStatus].
@ProviderFor(notificationPermissionStatus)
final notificationPermissionStatusProvider =
    AutoDisposeFutureProvider<NotificationPermissionStatus>.internal(
  notificationPermissionStatus,
  name: r'notificationPermissionStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationPermissionStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationPermissionStatusRef
    = AutoDisposeFutureProviderRef<NotificationPermissionStatus>;
String _$notificationPermissionHash() =>
    r'2450e0ab63fc20e52629ef0832b10346c08bccd8';

/// See also [NotificationPermission].
@ProviderFor(NotificationPermission)
final notificationPermissionProvider = AutoDisposeAsyncNotifierProvider<
    NotificationPermission, NotificationPermissionStatus>.internal(
  NotificationPermission.new,
  name: r'notificationPermissionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationPermissionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotificationPermission
    = AutoDisposeAsyncNotifier<NotificationPermissionStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
