import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/yearly_service.dart';

part 'yearly_providers.g.dart';

/// Provider for selected year (defaults to current year)
@riverpod
class SelectedYear extends _$SelectedYear {
  @override
  int build() => DateTime.now().year;

  void setYear(int year) {
    state = year;
  }

  void previousYear() {
    state = state - 1;
  }

  void nextYear() {
    state = state + 1;
  }

  void resetToCurrent() {
    state = DateTime.now().year;
  }
}

/// Provider for yearly tracking data
/// Returns a map of DateTime -> bool (true = tracked, false = missed)
@riverpod
Future<Map<DateTime, bool>> yearlyTracking(
  YearlyTrackingRef ref,
  int year,
) async {
  final service = ref.watch(yearlyServiceProvider);
  final trackingItems = await service.getYearlyTracking(year);
  
  // Convert list of tracking items to DateTime map
  final yearMap = <DateTime, bool>{};
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);
  
  for (final item in trackingItems) {
    try {
      final date = DateTime.parse(item.date);
      final dateOnly = DateTime(date.year, date.month, date.day);
      
      // Only include past or present dates
      if (!dateOnly.isAfter(todayDate)) {
        yearMap[dateOnly] = item.tracked;
      }
    } catch (_) {
      // Skip invalid dates
    }
  }
  
  return yearMap;
}

