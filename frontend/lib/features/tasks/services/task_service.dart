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
    
    // API returns array directly
    List<dynamic> tasksList;
    if (response['_items'] != null) {
      tasksList = response['_items'] as List;
    } else if (response is List) {
      tasksList = response as List;
    } else {
      return [];
    }
    
    return tasksList
        .map((json) => Task.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Create a new task
  Future<Task> createTask(String name, {bool isActive = true}) async {
    final response = await _apiClient.post(
      '/tasks',
      {'name': name, 'is_active': isActive},
      requireAuth: true,
    );
    return Task.fromJson(response);
  }

  /// Update an existing task
  Future<Task> updateTask(Task task) async {
    final updateData = <String, dynamic>{};
    if (task.name.isNotEmpty) {
      updateData['name'] = task.name;
    }
    updateData['is_active'] = task.isActive;
    
    final response = await _apiClient.patch(
      '/tasks/${task.id}',
      updateData,
      requireAuth: true,
    );
    return Task.fromJson(response);
  }
}

