import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/task.dart';
import '../services/task_service.dart';

part 'task_providers.g.dart';

/// Provider for all tasks
@riverpod
Future<List<Task>> tasks(TasksRef ref) async {
  final service = ref.watch(taskServiceProvider);
  return await service.getTasks();
}

/// Provider for creating a task
@riverpod
class CreateTask extends _$CreateTask {
  @override
  FutureOr<void> build() async {
    // Initial state
  }

  Future<Task> createTask(String name) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(taskServiceProvider);
      final newTask = await service.createTask(name);
      
      // Invalidate tasks provider to refresh list
      ref.invalidate(tasksProvider);
      
      state = const AsyncValue.data(null);
      return newTask;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

/// Provider for updating a task
@riverpod
class UpdateTask extends _$UpdateTask {
  @override
  FutureOr<void> build() async {
    // Initial state
  }

  Future<Task> updateTask(Task task) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(taskServiceProvider);
      final updatedTask = await service.updateTask(task);
      
      // Invalidate tasks provider to refresh list
      ref.invalidate(tasksProvider);
      
      state = const AsyncValue.data(null);
      return updatedTask;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

