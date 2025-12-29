// ignore_for_file: invalid_annotation_target
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/api_client.dart';
import '../models/dashboard_summary.dart';

part 'dashboard_service.g.dart';

@riverpod
DashboardService dashboardService(DashboardServiceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DashboardService(apiClient);
}

class DashboardService {
  final ApiClient _apiClient;

  DashboardService(this._apiClient);

  /// Get dashboard summary data
  Future<DashboardSummary> getDashboardSummary() async {
    try {
      final response = await _apiClient.get(
        '/dashboard/summary',
        requireAuth: true,
      );
      return DashboardSummary.fromJson(response);
    } on ApiException catch (e) {
      if (e.type == ApiErrorType.notFound) {
        // Endpoint doesn't exist yet - return empty summary
        return const DashboardSummary(
          randomMoment: null,
          randomMomentDate: null,
          averageSleep7Days: null,
          averageSleep30Days: null,
          sleepTrend: null,
          taskConsistencyPercentage: null,
        );
      }
      rethrow;
    }
  }
}

