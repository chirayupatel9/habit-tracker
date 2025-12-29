import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/layout/page_scaffold.dart';
import '../../../core/widgets/async_state_view.dart';
import '../../../core/theme/spacing.dart';
import '../models/task.dart';
import '../providers/task_providers.dart';
import '../widgets/task_tile.dart';

class TaskManagementScreen extends ConsumerWidget {
  const TaskManagementScreen({super.key});

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add Task'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Task Name',
              hintText: 'Enter task name',
            ),
            autofocus: true,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {
              if (formKey.currentState!.validate()) {
                _handleCreateTask(dialogContext, ref, nameController.text.trim());
              }
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a task name';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _handleCreateTask(dialogContext, ref, nameController.text.trim());
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleCreateTask(
    BuildContext dialogContext,
    WidgetRef ref,
    String name,
  ) async {
    try {
      await ref.read(createTaskProvider.notifier).createTask(name);
      if (dialogContext.mounted) {
        Navigator.of(dialogContext).pop();
        ScaffoldMessenger.of(dialogContext).showSnackBar(
          const SnackBar(
            content: Text('Task created successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (dialogContext.mounted) {
        ScaffoldMessenger.of(dialogContext).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to create task: ${e.toString().replaceAll('Exception: ', '')}',
            ),
            backgroundColor: Theme.of(dialogContext).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksProvider);
    final createState = ref.watch(createTaskProvider);
    final updateState = ref.watch(updateTaskProvider);

    // Show error snackbar if update fails
    updateState.whenOrNull(
      error: (error, stackTrace) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to update task: ${error.toString().replaceAll('Exception: ', '')}',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        });
      },
    );

    return PageScaffold(
      title: 'My Tasks',
      floatingActionButton: FloatingActionButton(
        onPressed: createState.isLoading
            ? null
            : () => _showAddTaskDialog(context, ref),
        child: createState.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Icon(Icons.add),
      ),
      child: AsyncStateView<List<Task>>(
        value: tasksAsync,
        onRetry: () {
          ref.invalidate(tasksProvider);
        },
        emptyState: EmptyStateConfig(
          icon: Icons.task_alt,
          title: 'No tasks yet',
          description: 'Tap the + button to add your first task',
        ),
        data: (tasks) {
          return Column(
            children: [
              ...tasks.map((task) {
                return Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.sm),
                  child: TaskTile(task: task),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

