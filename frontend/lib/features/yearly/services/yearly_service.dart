// ignore_for_file: invalid_annotation_target
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/api_client.dart';
import '../models/yearly_tracking.dart';

part 'yearly_service.g.dart';

@riverpod
YearlyService yearlyService(YearlyServiceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return YearlyService(apiClient);
}

class YearlyService {
  final ApiClient _apiClient;

  YearlyService(this._apiClient);

  /// Get yearly tracking data for a specific year
  Future<List<YearlyTrackingItem>> getYearlyTracking(int year) async {
    final response = await _apiClient.get(
      '/entries/yearly/$year',
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
        .map((json) => YearlyTrackingItem.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

