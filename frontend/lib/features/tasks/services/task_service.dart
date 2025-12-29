// ignore_for_file: invalid_annotation_target
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/api_client.dart';
import '../models/task.dart';

part 'task_service.g.dart';

@riverpod
TaskService taskService(TaskServiceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TaskService(apiClient);
}

class TaskService {
  final ApiClient _apiClient;

  TaskService(this._apiClient);

  /// Get all tasks
  Future<List<Task>> getTasks() async {
    final response = await _apiClient.get(
      '/tasks',
      requireAuth: true,
    );
    
    // Backend returns list of tasks
    if (response['tasks'] != null) {
      final tasksList = response['tasks'] as List;
      return tasksList.map((json) => Task.fromJson(json as Map<String, dynamic>)).toList();
    } else if (response is List) {
      return (response as List).map((json) => Task.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      return [];
    }
  }

  /// Create a new task
  Future<Task> createTask(String name) async {
    final response = await _apiClient.post(
      '/tasks',
      {'name': name},
      requireAuth: true,
    );
    return Task.fromJson(response);
  }

  /// Update an existing task
  Future<Task> updateTask(Task task) async {
    final response = await _apiClient.put(
      '/tasks/${task.id}',
      task.toJson(),
      requireAuth: true,
    );
    return Task.fromJson(response);
  }
}

