// ignore_for_file: invalid_annotation_target
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/api_client.dart';
import '../models/monthly_summary.dart';

part 'monthly_service.g.dart';

@riverpod
MonthlyService monthlyService(MonthlyServiceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MonthlyService(apiClient);
}

class MonthlyService {
  final ApiClient _apiClient;

  MonthlyService(this._apiClient);

  /// Get monthly summary for a specific year and month
  Future<MonthlySummary> getMonthlySummary(int year, int month) async {
    final response = await _apiClient.get(
      '/entries/month?year=$year&month=$month',
      requireAuth: true,
    );
    return MonthlySummary.fromJson(response);
  }
}

