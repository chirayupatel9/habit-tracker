import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/api_client.dart';
import '../models/daily_entry.dart';

part 'daily_entry_service.g.dart';

@riverpod
DailyEntryService dailyEntryService(DailyEntryServiceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DailyEntryService(apiClient);
}

class DailyEntryService {
  final ApiClient _apiClient;

  DailyEntryService(this._apiClient);

  /// Get daily entry for a specific date
  /// Returns null if entry doesn't exist
  Future<DailyEntry?> getEntry(String date) async {
    try {
      final response = await _apiClient.get(
        '/entries/$date',
        requireAuth: true,
      );
      return DailyEntry.fromJson(response);
    } on ApiException catch (e) {
      if (e.type == ApiErrorType.notFound) {
        return null;
      }
      rethrow;
    }
  }

  /// Create a new daily entry
  Future<DailyEntry> createEntry(DailyEntry entry) async {
    final response = await _apiClient.post(
      '/entries',
      entry.toJson(),
      requireAuth: true,
    );
    return DailyEntry.fromJson(response);
  }

  /// Update an existing daily entry
  Future<DailyEntry> updateEntry(String date, DailyEntry entry) async {
    final response = await _apiClient.put(
      '/entries/$date',
      entry.toJson(),
      requireAuth: true,
    );
    return DailyEntry.fromJson(response);
  }

  /// Save entry (create or update)
  Future<DailyEntry> saveEntry(DailyEntry entry) async {
    // Try to get existing entry first
    final existing = await getEntry(entry.date);
    
    if (existing != null) {
      return await updateEntry(entry.date, entry);
    } else {
      return await createEntry(entry);
    }
  }
}

