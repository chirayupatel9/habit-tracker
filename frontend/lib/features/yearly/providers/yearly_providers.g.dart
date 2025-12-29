// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yearly_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$yearlyTrackingHash() => r'44617750684c8ee72d117b53a176ad5711289458';

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

/// Provider for yearly tracking data
/// Returns a map of DateTime -> bool (true = tracked, false = missed)
///
/// Copied from [yearlyTracking].
@ProviderFor(yearlyTracking)
const yearlyTrackingProvider = YearlyTrackingFamily();

/// Provider for yearly tracking data
/// Returns a map of DateTime -> bool (true = tracked, false = missed)
///
/// Copied from [yearlyTracking].
class YearlyTrackingFamily extends Family<AsyncValue<Map<DateTime, bool>>> {
  /// Provider for yearly tracking data
  /// Returns a map of DateTime -> bool (true = tracked, false = missed)
  ///
  /// Copied from [yearlyTracking].
  const YearlyTrackingFamily();

  /// Provider for yearly tracking data
  /// Returns a map of DateTime -> bool (true = tracked, false = missed)
  ///
  /// Copied from [yearlyTracking].
  YearlyTrackingProvider call(
    int year,
  ) {
    return YearlyTrackingProvider(
      year,
    );
  }

  @override
  YearlyTrackingProvider getProviderOverride(
    covariant YearlyTrackingProvider provider,
  ) {
    return call(
      provider.year,
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
  String? get name => r'yearlyTrackingProvider';
}

/// Provider for yearly tracking data
/// Returns a map of DateTime -> bool (true = tracked, false = missed)
///
/// Copied from [yearlyTracking].
class YearlyTrackingProvider
    extends AutoDisposeFutureProvider<Map<DateTime, bool>> {
  /// Provider for yearly tracking data
  /// Returns a map of DateTime -> bool (true = tracked, false = missed)
  ///
  /// Copied from [yearlyTracking].
  YearlyTrackingProvider(
    int year,
  ) : this._internal(
          (ref) => yearlyTracking(
            ref as YearlyTrackingRef,
            year,
          ),
          from: yearlyTrackingProvider,
          name: r'yearlyTrackingProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$yearlyTrackingHash,
          dependencies: YearlyTrackingFamily._dependencies,
          allTransitiveDependencies:
              YearlyTrackingFamily._allTransitiveDependencies,
          year: year,
        );

  YearlyTrackingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
  }) : super.internal();

  final int year;

  @override
  Override overrideWith(
    FutureOr<Map<DateTime, bool>> Function(YearlyTrackingRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: YearlyTrackingProvider._internal(
        (ref) => create(ref as YearlyTrackingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<DateTime, bool>> createElement() {
    return _YearlyTrackingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YearlyTrackingProvider && other.year == year;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin YearlyTrackingRef on AutoDisposeFutureProviderRef<Map<DateTime, bool>> {
  /// The parameter `year` of this provider.
  int get year;
}

class _YearlyTrackingProviderElement
    extends AutoDisposeFutureProviderElement<Map<DateTime, bool>>
    with YearlyTrackingRef {
  _YearlyTrackingProviderElement(super.provider);

  @override
  int get year => (origin as YearlyTrackingProvider).year;
}

String _$selectedYearHash() => r'8235e6d7129a4b6ff9283c538753d175eb15d4a9';

/// Provider for selected year (defaults to current year)
///
/// Copied from [SelectedYear].
@ProviderFor(SelectedYear)
final selectedYearProvider =
    AutoDisposeNotifierProvider<SelectedYear, int>.internal(
  SelectedYear.new,
  name: r'selectedYearProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectedYearHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedYear = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
