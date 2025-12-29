// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_entry_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dailyEntryHash() => r'570c54d7cc34eb6a6c55248a6736423b07e84dea';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for daily entry for a specific date
///
/// Copied from [dailyEntry].
@ProviderFor(dailyEntry)
const dailyEntryProvider = DailyEntryFamily();

/// Provider for daily entry for a specific date
///
/// Copied from [dailyEntry].
class DailyEntryFamily extends Family<AsyncValue<DailyEntry?>> {
  /// Provider for daily entry for a specific date
  ///
  /// Copied from [dailyEntry].
  const DailyEntryFamily();

  /// Provider for daily entry for a specific date
  ///
  /// Copied from [dailyEntry].
  DailyEntryProvider call(
    DateTime date,
  ) {
    return DailyEntryProvider(
      date,
    );
  }

  @override
  DailyEntryProvider getProviderOverride(
    covariant DailyEntryProvider provider,
  ) {
    return call(
      provider.date,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dailyEntryProvider';
}

/// Provider for daily entry for a specific date
///
/// Copied from [dailyEntry].
class DailyEntryProvider extends AutoDisposeFutureProvider<DailyEntry?> {
  /// Provider for daily entry for a specific date
  ///
  /// Copied from [dailyEntry].
  DailyEntryProvider(
    DateTime date,
  ) : this._internal(
          (ref) => dailyEntry(
            ref as DailyEntryRef,
            date,
          ),
          from: dailyEntryProvider,
          name: r'dailyEntryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dailyEntryHash,
          dependencies: DailyEntryFamily._dependencies,
          allTransitiveDependencies:
              DailyEntryFamily._allTransitiveDependencies,
          date: date,
        );

  DailyEntryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    FutureOr<DailyEntry?> Function(DailyEntryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DailyEntryProvider._internal(
        (ref) => create(ref as DailyEntryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DailyEntry?> createElement() {
    return _DailyEntryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DailyEntryProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DailyEntryRef on AutoDisposeFutureProviderRef<DailyEntry?> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _DailyEntryProviderElement
    extends AutoDisposeFutureProviderElement<DailyEntry?> with DailyEntryRef {
  _DailyEntryProviderElement(super.provider);

  @override
  DateTime get date => (origin as DailyEntryProvider).date;
}

String _$selectedDateHash() => r'1029177ea87f93020fdda4ac1381d9f15a2a16f8';

/// Provider for selected date (defaults to today)
///
/// Copied from [SelectedDate].
@ProviderFor(SelectedDate)
final selectedDateProvider =
    AutoDisposeNotifierProvider<SelectedDate, DateTime>.internal(
  SelectedDate.new,
  name: r'selectedDateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectedDateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedDate = AutoDisposeNotifier<DateTime>;
String _$saveDailyEntryHash() => r'83cd83ca19e308d0215d2b023028a2384000c542';

/// Provider for saving daily entry
///
/// Copied from [SaveDailyEntry].
@ProviderFor(SaveDailyEntry)
final saveDailyEntryProvider =
    AutoDisposeAsyncNotifierProvider<SaveDailyEntry, void>.internal(
  SaveDailyEntry.new,
  name: r'saveDailyEntryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveDailyEntryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SaveDailyEntry = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
