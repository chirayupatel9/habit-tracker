import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/layout/page_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/async_state_view.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
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

    return PageScaffold(
      title: 'Monthly View',
      child: AsyncStateView<List<MonthlyAggregation>>(
        value: summaryAsync,
        onRetry: () {
          ref.invalidate(monthlySummaryProvider(year, month));
        },
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Month Header with Navigation
        _buildMonthHeader(context, ref, selectedMonth),
        AppSpacing.heightLg,

        // Random Moment Section
        _buildRandomMomentSection(context, randomMoment),
        AppSpacing.heightLg,

        // Task Summary Section
        _buildTaskSummarySection(
          context,
          ref,
          taskCompletionSummary,
          selectedMonth,
        ),
        AppSpacing.heightLg,

        // Average Sleep Section
        _buildAverageSleepSection(context, averageSleep),
        AppSpacing.heightLg,

        // Daily Notes List
        _buildDailyNotesSection(
          context,
          ref,
          dailyNotes,
          selectedMonth,
        ),
      ],
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

    return AppCard(
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
                style: Theme.of(context).pageTitle,
              ),
              if (isCurrentMonth)
                Text(
                  'Current Month',
                  style: Theme.of(context).caption.copyWith(
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
    );
  }

  Widget _buildRandomMomentSection(
    BuildContext context,
    ({String date, String moment})? randomMoment,
  ) {
    return AppCard(
      title: 'Random Moment of the Month',
      icon: Icons.auto_awesome,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (randomMoment != null) ...[
            Text(
              randomMoment.moment,
              style: Theme.of(context).body,
            ),
            AppSpacing.heightSm,
            Text(
              _formatDateSubtitle(randomMoment.date),
              style: Theme.of(context).subtle,
            ),
          ] else
            Text(
              'No moments recorded this month',
              style: Theme.of(context).subtle,
            ),
        ],
      ),
    );
  }

  Widget _buildTaskSummarySection(
    BuildContext context,
    WidgetRef ref,
    Map<String, int>? taskCompletionSummary,
    DateTime selectedMonth,
  ) {
    return AppCard(
      title: 'Task Summary',
      icon: Icons.checklist,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (taskCompletionSummary != null && taskCompletionSummary.isNotEmpty)
            ...taskCompletionSummary.entries.map((entry) {
              final taskName = entry.key;
              final completionCount = entry.value;
              final daysInMonth = _getDaysInMonth(
                selectedMonth.year,
                selectedMonth.month,
              );
              return Padding(
                padding: AppSpacing.verticalSm,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        taskName,
                        style: Theme.of(context).body,
                      ),
                    ),
                    Text(
                      '$completionCount / $daysInMonth days',
                      style: Theme.of(context).caption,
                    ),
                  ],
                ),
              );
            })
          else
            Text(
              'No tasks recorded this month',
              style: Theme.of(context).subtle,
            ),
        ],
      ),
    );
  }

  Widget _buildAverageSleepSection(
    BuildContext context,
    double? averageSleep,
  ) {
    return AppCard(
      title: 'Average Sleep',
      icon: Icons.bedtime,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (averageSleep != null)
            Text(
              '${averageSleep.toStringAsFixed(1)} hours',
              style: Theme.of(context).pageTitle.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            )
          else
            Text(
              'No sleep data available',
              style: Theme.of(context).subtle,
            ),
        ],
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

    return AppCard(
      title: 'Daily Notes',
      icon: Icons.note_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.sm * 1.5,
          horizontal: AppSpacing.sm,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 70,
              child: Text(
                dateFormatted,
                style: Theme.of(context).caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            AppSpacing.widthMd,
            Expanded(
              child: Text(
                note ?? 'No entry',
                style: note != null
                    ? Theme.of(context).body
                    : Theme.of(context).subtle,
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

