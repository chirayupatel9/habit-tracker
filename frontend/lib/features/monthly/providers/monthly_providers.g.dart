// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$monthlySummaryHash() => r'bdc4d156b317ada5e4188f5fee5e288b906ed11b';

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

/// Provider for monthly summary
///
/// Copied from [monthlySummary].
@ProviderFor(monthlySummary)
const monthlySummaryProvider = MonthlySummaryFamily();

/// Provider for monthly summary
///
/// Copied from [monthlySummary].
class MonthlySummaryFamily
    extends Family<AsyncValue<List<MonthlyAggregation>>> {
  /// Provider for monthly summary
  ///
  /// Copied from [monthlySummary].
  const MonthlySummaryFamily();

  /// Provider for monthly summary
  ///
  /// Copied from [monthlySummary].
  MonthlySummaryProvider call(
    int year,
    int month,
  ) {
    return MonthlySummaryProvider(
      year,
      month,
    );
  }

  @override
  MonthlySummaryProvider getProviderOverride(
    covariant MonthlySummaryProvider provider,
  ) {
    return call(
      provider.year,
      provider.month,
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
  String? get name => r'monthlySummaryProvider';
}

/// Provider for monthly summary
///
/// Copied from [monthlySummary].
class MonthlySummaryProvider
    extends AutoDisposeFutureProvider<List<MonthlyAggregation>> {
  /// Provider for monthly summary
  ///
  /// Copied from [monthlySummary].
  MonthlySummaryProvider(
    int year,
    int month,
  ) : this._internal(
          (ref) => monthlySummary(
            ref as MonthlySummaryRef,
            year,
            month,
          ),
          from: monthlySummaryProvider,
          name: r'monthlySummaryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$monthlySummaryHash,
          dependencies: MonthlySummaryFamily._dependencies,
          allTransitiveDependencies:
              MonthlySummaryFamily._allTransitiveDependencies,
          year: year,
          month: month,
        );

  MonthlySummaryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
    required this.month,
  }) : super.internal();

  final int year;
  final int month;

  @override
  Override overrideWith(
    FutureOr<List<MonthlyAggregation>> Function(MonthlySummaryRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthlySummaryProvider._internal(
        (ref) => create(ref as MonthlySummaryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<MonthlyAggregation>> createElement() {
    return _MonthlySummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlySummaryProvider &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MonthlySummaryRef
    on AutoDisposeFutureProviderRef<List<MonthlyAggregation>> {
  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _MonthlySummaryProviderElement
    extends AutoDisposeFutureProviderElement<List<MonthlyAggregation>>
    with MonthlySummaryRef {
  _MonthlySummaryProviderElement(super.provider);

  @override
  int get year => (origin as MonthlySummaryProvider).year;
  @override
  int get month => (origin as MonthlySummaryProvider).month;
}

String _$selectedMonthHash() => r'9d926b7dae0a05c610a84af1516c0d8fe70ecac1';

/// Provider for selected month (defaults to current month)
///
/// Copied from [SelectedMonth].
@ProviderFor(SelectedMonth)
final selectedMonthProvider =
    AutoDisposeNotifierProvider<SelectedMonth, DateTime>.internal(
  SelectedMonth.new,
  name: r'selectedMonthProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedMonthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedMonth = AutoDisposeNotifier<DateTime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
