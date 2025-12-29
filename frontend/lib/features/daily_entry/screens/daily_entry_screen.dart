import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/app_drawer.dart';
import '../models/daily_entry.dart';
import '../models/task_completion.dart';
import '../providers/daily_entry_providers.dart';
import '../../tasks/providers/task_providers.dart';
import '../../tasks/models/task.dart';

class DailyEntryScreen extends ConsumerStatefulWidget {
  const DailyEntryScreen({super.key});

  @override
  ConsumerState<DailyEntryScreen> createState() => _DailyEntryScreenState();
}

class _DailyEntryScreenState extends ConsumerState<DailyEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _momentController = TextEditingController();
  final _sleepHoursController = TextEditingController();
  final _noteController = TextEditingController();
  // Map of task_id -> completed
  final _taskCompletions = <String, bool>{};

  @override
  void dispose() {
    _momentController.dispose();
    _sleepHoursController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _loadEntryData(DailyEntry? entry, List<Task> tasks) {
    if (entry == null) {
      // Clear all fields if no entry exists
      _momentController.clear();
      _sleepHoursController.clear();
      _noteController.clear();
      _taskCompletions.clear();
      // Initialize with all active tasks as unchecked
      for (final task in tasks.where((t) => t.isActive)) {
        _taskCompletions[task.id] = false;
      }
      return;
    }

    // Load existing entry data
    _momentController.text = entry.momentOfDay ?? '';
    _sleepHoursController.text = entry.sleepHours?.toString() ?? '';
    _noteController.text = entry.dailyNote ?? '';
    
    // Load task completions
    _taskCompletions.clear();
    // First, add all active tasks as unchecked
    for (final task in tasks.where((t) => t.isActive)) {
      _taskCompletions[task.id] = false;
    }
    // Then, update with actual completions from entry
    for (final completion in entry.taskCompletions) {
      _taskCompletions[completion.taskId] = completion.completed;
    }
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final selectedDate = ref.read(selectedDateProvider);
    final dateString = _formatDate(selectedDate);

    // Convert task completions map to TaskCompletion list
    final taskCompletions = _taskCompletions.entries
        .map((entry) => TaskCompletion(
              taskId: entry.key,
              completed: entry.value,
            ))
        .toList();

    final entry = DailyEntry(
      date: dateString,
      momentOfDay: _momentController.text.trim().isEmpty
          ? null
          : _momentController.text.trim(),
      sleepHours: _sleepHoursController.text.trim().isEmpty
          ? null
          : double.tryParse(_sleepHoursController.text.trim()),
      dailyNote: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      taskCompletions: taskCompletions,
    );

    try {
      await ref.read(saveDailyEntryProvider.notifier).saveEntry(entry);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Entry saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to save entry: ${e.toString().replaceAll('Exception: ', '')}',
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final selectedDate = ref.read(selectedDateProvider);
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      ref.read(selectedDateProvider.notifier).setDate(picked);
    }
  }


  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String _formatDisplayDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(date.year, date.month, date.day);

    if (selected == today) {
      return 'Today';
    } else if (selected == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final entryAsync = ref.watch(dailyEntryProvider(selectedDate));
    final saveState = ref.watch(saveDailyEntryProvider);
    final tasksAsync = ref.watch(tasksProvider);

    // Load entry data when it changes
    tasksAsync.whenData((tasks) {
      entryAsync.whenData((entry) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _loadEntryData(entry, tasks);
        });
      });
    });

    final isLoading = saveState.isLoading;
    final isSaving = isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Entry'),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: KeyboardAwareScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Date Header
                  _buildDateHeader(context, selectedDate),
                  const SizedBox(height: 24),

                  // Moment of the Day
                  TextFormField(
                    controller: _momentController,
                    decoration: const InputDecoration(
                      labelText: 'Moment of the Day',
                      hintText: 'How was your day?',
                      prefixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),

                  // Tasks Section
                  tasksAsync.when(
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const Text('Error loading tasks'),
                    data: (tasks) => _buildTasksSection(tasks),
                  ),
                  const SizedBox(height: 16),

                  // Sleep Hours
                  TextFormField(
                    controller: _sleepHoursController,
                    decoration: const InputDecoration(
                      labelText: 'Sleep (hours)',
                      hintText: '8.5',
                      prefixIcon: Icon(Icons.bedtime_outlined),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ),
                    ],
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final hours = double.tryParse(value);
                        if (hours == null) {
                          return 'Please enter a valid number';
                        }
                        if (hours < 0 || hours > 24) {
                          return 'Sleep hours must be between 0 and 24';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Notes
                  TextFormField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      labelText: 'Notes (optional)',
                      hintText: 'Add any additional notes...',
                      prefixIcon: Icon(Icons.note_outlined),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 4,
                    textInputAction: TextInputAction.newline,
                  ),
                  const SizedBox(height: 32),

                  // Save Button
                  ElevatedButton(
                    onPressed: (isSaving || entryAsync.isLoading)
                        ? null
                        : _handleSave,
                    child: isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('Save Entry'),
                  ),

                  // Error message
                  if (entryAsync.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'Error loading entry: ${entryAsync.error}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateHeader(BuildContext context, DateTime selectedDate) {
    final isToday = _isToday(selectedDate);

    return Card(
      child: InkWell(
        onTap: () => _selectDate(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatDisplayDate(selectedDate),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('EEEE').format(selectedDate),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (!isToday)
                    TextButton.icon(
                      onPressed: () {
                        ref.read(selectedDateProvider.notifier).resetToToday();
                      },
                      icon: const Icon(Icons.today),
                      label: const Text('Today'),
                    ),
                  Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTasksSection(List<Task> tasks) {
    final activeTasks = tasks.where((t) => t.isActive).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Tasks',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        if (activeTasks.isEmpty)
          Text(
            'No active tasks. Add tasks in the Tasks screen.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
          )
        else
          ...activeTasks.map((task) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                child: CheckboxListTile(
                  title: Text(task.name),
                  value: _taskCompletions[task.id] ?? false,
                  onChanged: (value) {
                    setState(() {
                      _taskCompletions[task.id] = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            );
          }),
      ],
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}

/// Keyboard-aware scrollable widget
class KeyboardAwareScrollView extends StatelessWidget {
  final Widget child;

  const KeyboardAwareScrollView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: child,
    );
  }
}

