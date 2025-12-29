import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/monthly_summary.dart';
import '../providers/monthly_providers.dart';
import '../../daily_entry/providers/daily_entry_providers.dart';

class MonthlyScreen extends ConsumerWidget {
  const MonthlyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMonth = ref.watch(selectedMonthProvider);
    final year = selectedMonth.year;
    final month = selectedMonth.month;
    final summaryAsync = ref.watch(monthlySummaryProvider(year, month));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly View'),
      ),
      body: summaryAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading monthly summary',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString().replaceAll('Exception: ', ''),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(monthlySummaryProvider(year, month));
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (summary) => _buildContent(context, ref, summary, selectedMonth),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<MonthlyAggregation> aggregations,
    DateTime selectedMonth,
  ) {
    // Calculate aggregations from the list
    final randomMoment = _getRandomMoment(aggregations);
    final taskCompletionSummary = _getTaskCompletionSummary(aggregations);
    final averageSleep = _getAverageSleep(aggregations);
    final dailyNotes = _getDailyNotes(aggregations);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Month Header with Navigation
            _buildMonthHeader(context, ref, selectedMonth),
            const SizedBox(height: 24),

            // Random Moment Section
            _buildRandomMomentSection(context, randomMoment),
            const SizedBox(height: 24),

            // Task Summary Section
            _buildTaskSummarySection(
              context,
              ref,
              taskCompletionSummary,
              selectedMonth,
            ),
            const SizedBox(height: 24),

            // Average Sleep Section
            _buildAverageSleepSection(context, averageSleep),
            const SizedBox(height: 24),

            // Daily Notes List
            _buildDailyNotesSection(
              context,
              ref,
              dailyNotes,
              selectedMonth,
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods to extract data from aggregations
  ({String date, String moment})? _getRandomMoment(
    List<MonthlyAggregation> aggregations,
  ) {
    final withMoments = aggregations
        .where((a) => a.momentOfDay != null && a.momentOfDay!.isNotEmpty)
        .toList();
    if (withMoments.isEmpty) return null;
    final random = withMoments[(DateTime.now().millisecondsSinceEpoch %
            withMoments.length)];
    return (date: random.date, moment: random.momentOfDay!);
  }

  Map<String, int> _getTaskCompletionSummary(
    List<MonthlyAggregation> aggregations,
  ) {
    final summary = <String, int>{};
    for (final agg in aggregations) {
      if (agg.taskCompletionCounts != null) {
        for (final entry in agg.taskCompletionCounts!.entries) {
          summary[entry.key] = (summary[entry.key] ?? 0) + entry.value;
        }
      }
    }
    return summary;
  }

  double? _getAverageSleep(List<MonthlyAggregation> aggregations) {
    final sleepValues = aggregations
        .where((a) => a.sleepHours != null)
        .map((a) => a.sleepHours!)
        .toList();
    if (sleepValues.isEmpty) return null;
    return sleepValues.reduce((a, b) => a + b) / sleepValues.length;
  }

  List<({String date, String? note})> _getDailyNotes(
    List<MonthlyAggregation> aggregations,
  ) {
    return aggregations
        .where((a) => a.dailyNote != null && a.dailyNote!.isNotEmpty)
        .map((a) => (date: a.date, note: a.dailyNote))
        .toList();
  }

  Widget _buildMonthHeader(
    BuildContext context,
    WidgetRef ref,
    DateTime selectedMonth,
  ) {
    final monthName = DateFormat('MMMM yyyy').format(selectedMonth);
    final isCurrentMonth = _isCurrentMonth(selectedMonth);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                ref.read(selectedMonthProvider.notifier).previousMonth();
              },
              icon: const Icon(Icons.chevron_left),
            ),
            Column(
              children: [
                Text(
                  monthName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (isCurrentMonth)
                  Text(
                    'Current Month',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
              ],
            ),
            Row(
              children: [
                if (!isCurrentMonth)
                  TextButton(
                    onPressed: () {
                      ref.read(selectedMonthProvider.notifier).resetToCurrent();
                    },
                    child: const Text('Today'),
                  ),
                IconButton(
                  onPressed: () {
                    ref.read(selectedMonthProvider.notifier).nextMonth();
                  },
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRandomMomentSection(
    BuildContext context,
    ({String date, String moment})? randomMoment,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Random Moment of the Month',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (randomMoment != null) ...[
              Text(
                randomMoment.moment,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                _formatDateSubtitle(randomMoment.date),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ] else
              Text(
                'No moments recorded this month',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskSummarySection(
    BuildContext context,
    WidgetRef ref,
    Map<String, int>? taskCompletionSummary,
    DateTime selectedMonth,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.checklist,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Task Summary',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (taskCompletionSummary != null && taskCompletionSummary.isNotEmpty)
              ...taskCompletionSummary.entries.map((entry) {
                final taskName = entry.key;
                final completionCount = entry.value;
                final daysInMonth = _getDaysInMonth(
                  selectedMonth.year,
                  selectedMonth.month,
                );
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          taskName,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Text(
                        '$completionCount / $daysInMonth days',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                    ],
                  ),
                );
              })
            else
              Text(
                'No tasks recorded this month',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAverageSleepSection(
    BuildContext context,
    double? averageSleep,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bedtime,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Average Sleep',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (averageSleep != null)
              Text(
                '${averageSleep.toStringAsFixed(1)} hours',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              )
            else
              Text(
                'No sleep data available',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyNotesSection(
    BuildContext context,
    WidgetRef ref,
    List<({String date, String? note})> dailyNotes,
    DateTime selectedMonth,
  ) {
    final daysInMonth = _getDaysInMonth(selectedMonth.year, selectedMonth.month);
    final notesMap = <String, String?>{};

    // Create a map of date -> note for quick lookup
    for (final note in dailyNotes) {
      notesMap[note.date] = note.note;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.note_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Daily Notes',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Generate list for all days in month
            ...List.generate(daysInMonth, (index) {
              final day = index + 1;
              final date = DateTime(selectedMonth.year, selectedMonth.month, day);
              final dateString = _formatDate(date);
              final note = notesMap[dateString];

              return _buildDailyNoteRow(
                context,
                ref,
                date,
                note,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyNoteRow(
    BuildContext context,
    WidgetRef ref,
    DateTime date,
    String? note,
  ) {
    final dateFormatted = DateFormat('MMM dd').format(date);

    return InkWell(
      onTap: () {
        // Navigate to DailyEntryScreen for this date
        ref.read(selectedDateProvider.notifier).setDate(date);
        context.push('/daily-entry');
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 70,
              child: Text(
                dateFormatted,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                note ?? 'No entry',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: note != null
                          ? null
                          : Colors.grey.shade600,
                      fontStyle: note == null ? FontStyle.italic : null,
                    ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateSubtitle(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '— ${DateFormat('MMM d').format(date)}';
    } catch (_) {
      return '— $dateString';
    }
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  bool _isCurrentMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }
}

