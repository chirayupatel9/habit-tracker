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

  /// Get monthly aggregation for a specific year and month
  Future<List<MonthlyAggregation>> getMonthlySummary(int year, int month) async {
    final response = await _apiClient.get(
      '/entries/monthly/$year/$month',
      requireAuth: true,
    );
    
    List<dynamic> itemsList;
    if (response['_items'] != null) {
      itemsList = response['_items'] as List;
    } else if (response is List) {
      itemsList = response as List;
    } else {
      return [];
    }
    
    return itemsList
        .map((json) => MonthlyAggregation.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

