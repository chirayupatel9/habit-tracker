import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/api_client.dart';
import '../../../services/api_client.dart' show ApiException, ApiErrorType;
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
  Future<DailyEntry?> getEntryByDate(String date) async {
    try {
      // Get all entries and find by date
      final response = await _apiClient.get(
        '/entries?skip=0&limit=1000',
        requireAuth: true,
      );
      
      List<dynamic> entriesList;
      if (response['_items'] != null) {
        entriesList = response['_items'] as List;
      } else if (response is List) {
        entriesList = response as List;
      } else {
        return null;
      }
      
      for (var entryJson in entriesList) {
        final entry = DailyEntry.fromJson(entryJson as Map<String, dynamic>);
        if (entry.date == date) {
          return entry;
        }
      }
      return null;
    } on ApiException catch (e) {
      if (e.type == ApiErrorType.notFound) {
        return null;
      }
      rethrow;
    }
  }

  /// Get daily entry by ID
  Future<DailyEntry> getEntryById(String entryId) async {
    final response = await _apiClient.get(
      '/entries/$entryId',
      requireAuth: true,
    );
    return DailyEntry.fromJson(response);
  }

  /// Create a new daily entry
  Future<DailyEntry> createEntry(DailyEntry entry) async {
    // Prepare create payload (only required/optional fields, no response fields)
    final createData = {
      'date': entry.date,
      'moment_of_day': entry.momentOfDay ?? '',
      'sleep_hours': entry.sleepHours ?? 0,
      if (entry.dailyNote != null) 'daily_note': entry.dailyNote,
      'task_completions': entry.taskCompletions
          .map((tc) => {
                'task_id': tc.taskId,
                'completed': tc.completed,
                if (tc.feedback != null) 'feedback': tc.feedback,
              })
          .toList(),
    };
    
    final response = await _apiClient.post(
      '/entries',
      createData,
      requireAuth: true,
    );
    return DailyEntry.fromJson(response);
  }

  /// Update an existing daily entry
  Future<DailyEntry> updateEntry(String entryId, DailyEntry entry) async {
    // Prepare update payload (only fields that can be updated)
    final updateData = <String, dynamic>{};
    if (entry.momentOfDay != null) {
      updateData['moment_of_day'] = entry.momentOfDay;
    }
    if (entry.sleepHours != null) {
      updateData['sleep_hours'] = entry.sleepHours;
    }
    if (entry.dailyNote != null) {
      updateData['daily_note'] = entry.dailyNote;
    }
    if (entry.taskCompletions.isNotEmpty) {
      updateData['task_completions'] = entry.taskCompletions
          .map((tc) => {
                'task_id': tc.taskId,
                'completed': tc.completed,
                if (tc.feedback != null) 'feedback': tc.feedback,
              })
          .toList();
    }
    
    final response = await _apiClient.patch(
      '/entries/$entryId',
      updateData,
      requireAuth: true,
    );
    return DailyEntry.fromJson(response);
  }

  /// Save entry (create or update)
  Future<DailyEntry> saveEntry(DailyEntry entry) async {
    // Try to get existing entry first by date
    final existing = await getEntryByDate(entry.date);
    
    if (existing != null && existing.id != null) {
      return await updateEntry(existing.id!, entry);
    } else {
      return await createEntry(entry);
    }
  }
}

