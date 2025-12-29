import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../providers/task_providers.dart';

class TaskTile extends ConsumerWidget {
  final Task task;

  const TaskTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateState = ref.watch(updateTaskProvider);

    return Card(
      child: ListTile(
        leading: Icon(
          Icons.check_circle_outline,
          color: task.isActive
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
        ),
        title: Text(
          task.name,
          style: TextStyle(
            decoration: task.isActive ? null : TextDecoration.lineThrough,
            color: task.isActive ? null : Colors.grey,
          ),
        ),
        trailing: Switch(
          value: task.isActive,
          onChanged: updateState.isLoading
              ? null
              : (value) {
                  // Optimistic update
                  final updatedTask = task.copyWith(isActive: value);
                  ref.read(updateTaskProvider.notifier).updateTask(updatedTask);
                },
        ),
        onTap: () {
          _showEditDialog(context, ref, task);
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Task task) {
    final nameController = TextEditingController(text: task.name);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Task'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Task Name',
              hintText: 'Enter task name',
            ),
            autofocus: true,
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
                final updatedTask = task.copyWith(
                  name: nameController.text.trim(),
                );
                ref.read(updateTaskProvider.notifier).updateTask(updatedTask);
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

