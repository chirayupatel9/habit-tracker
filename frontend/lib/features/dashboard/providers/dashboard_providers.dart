import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/dashboard_summary.dart';
import '../services/dashboard_service.dart';

part 'dashboard_providers.g.dart';

/// Provider for dashboard summary data
@riverpod
Future<DashboardSummary> dashboardSummary(DashboardSummaryRef ref) async {
  final service = ref.watch(dashboardServiceProvider);
  return await service.getDashboardSummary();
}

