// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasksHash() => r'78d8f39cd74d1176c4a7c9f8f38e2b0acb735ddb';

/// Provider for all tasks
///
/// Copied from [tasks].
@ProviderFor(tasks)
final tasksProvider = AutoDisposeFutureProvider<List<Task>>.internal(
  tasks,
  name: r'tasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TasksRef = AutoDisposeFutureProviderRef<List<Task>>;
String _$createTaskHash() => r'9981388bb596c07d02dce29b0283065ffdf7f88d';

/// Provider for creating a task
///
/// Copied from [CreateTask].
@ProviderFor(CreateTask)
final createTaskProvider =
    AutoDisposeAsyncNotifierProvider<CreateTask, void>.internal(
  CreateTask.new,
  name: r'createTaskProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$createTaskHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreateTask = AutoDisposeAsyncNotifier<void>;
String _$updateTaskHash() => r'256d37057ecb7d46b37b9beb470707d4459f9114';

/// Provider for updating a task
///
/// Copied from [UpdateTask].
@ProviderFor(UpdateTask)
final updateTaskProvider =
    AutoDisposeAsyncNotifierProvider<UpdateTask, void>.internal(
  UpdateTask.new,
  name: r'updateTaskProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$updateTaskHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdateTask = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
