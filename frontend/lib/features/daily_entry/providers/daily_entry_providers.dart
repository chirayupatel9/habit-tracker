import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/daily_entry.dart';
import '../services/daily_entry_service.dart';

part 'daily_entry_providers.g.dart';

/// Provider for selected date (defaults to today)
@riverpod
class SelectedDate extends _$SelectedDate {
  @override
  DateTime build() => DateTime.now();

  void setDate(DateTime date) {
    state = date;
  }

  void resetToToday() {
    state = DateTime.now();
  }
}

/// Provider for daily entry for a specific date
@riverpod
Future<DailyEntry?> dailyEntry(
  DailyEntryRef ref,
  DateTime date,
) async {
  final service = ref.watch(dailyEntryServiceProvider);
  final dateString = _formatDate(date);
  return await service.getEntryByDate(dateString);
}

/// Provider for saving daily entry
@riverpod
class SaveDailyEntry extends _$SaveDailyEntry {
  @override
  FutureOr<void> build() async {
    // Initial state
  }

  Future<void> saveEntry(DailyEntry entry) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(dailyEntryServiceProvider);
      await service.saveEntry(entry);
      
      // Invalidate the daily entry provider to refresh data
      final entryDate = DateTime.parse(entry.date);
      ref.invalidate(dailyEntryProvider(entryDate));
      
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

/// Helper function to format DateTime to YYYY-MM-DD string
String _formatDate(DateTime date) {
  final year = date.year.toString();
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}

