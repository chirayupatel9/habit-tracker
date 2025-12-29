// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileHash() => r'b9ca1032285283151e09497bf62d0b6cf4b06b5a';

/// Provider for user profile data
///
/// Copied from [userProfile].
@ProviderFor(userProfile)
final userProfileProvider = AutoDisposeFutureProvider<UserProfile>.internal(
  userProfile,
  name: r'userProfileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserProfileRef = AutoDisposeFutureProviderRef<UserProfile>;
String _$updateProfileHash() => r'cd9200bfb2d4adee63e4386dc81217fe3096a22e';

/// Provider for updating user profile
///
/// Copied from [UpdateProfile].
@ProviderFor(UpdateProfile)
final updateProfileProvider =
    AutoDisposeAsyncNotifierProvider<UpdateProfile, void>.internal(
  UpdateProfile.new,
  name: r'updateProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdateProfile = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
