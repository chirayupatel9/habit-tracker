import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/monthly_summary.dart';
import '../services/monthly_service.dart';

part 'monthly_providers.g.dart';

/// Provider for selected month (defaults to current month)
@riverpod
class SelectedMonth extends _$SelectedMonth {
  @override
  DateTime build() => DateTime.now();

  void setMonth(DateTime month) {
    state = month;
  }

  void previousMonth() {
    final current = state;
    state = DateTime(current.year, current.month - 1, 1);
  }

  void nextMonth() {
    final current = state;
    state = DateTime(current.year, current.month + 1, 1);
  }

  void resetToCurrent() {
    state = DateTime.now();
  }
}

/// Provider for monthly summary
@riverpod
Future<MonthlySummary> monthlySummary(
  MonthlySummaryRef ref,
  int year,
  int month,
) async {
  final service = ref.watch(monthlyServiceProvider);
  return await service.getMonthlySummary(year, month);
}

