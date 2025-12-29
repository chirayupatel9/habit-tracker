import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/yearly_tracking.dart';
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
  final tracking = await service.getYearlyTracking(year);
  
  // Convert tracked dates (strings) to DateTime set for quick lookup
  final trackedSet = <DateTime>{};
  for (final dateStr in tracking.trackedDates) {
    try {
      final date = DateTime.parse(dateStr);
      trackedSet.add(DateTime(date.year, date.month, date.day));
    } catch (_) {
      // Skip invalid dates
    }
  }
  
  // Create a map for all days in the year
  final yearMap = <DateTime, bool>{};
  final startOfYear = DateTime(year, 1, 1);
  final endOfYear = DateTime(year, 12, 31);
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);
  
  var currentDate = startOfYear;
  while (currentDate.isBefore(endOfYear) || currentDate.isAtSameMomentAs(endOfYear)) {
    final dateOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);
    
    // Future dates are not tracked or missed
    if (dateOnly.isAfter(todayDate)) {
      // Don't add future dates to the map
    } else {
      // Past or present dates: true if tracked, false if missed
      yearMap[dateOnly] = trackedSet.contains(dateOnly);
    }
    
    currentDate = currentDate.add(const Duration(days: 1));
  }
  
  return yearMap;
}

