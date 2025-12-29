import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/errors/app_error.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../models/dashboard_summary.dart';
import '../providers/dashboard_providers.dart';
import '../widgets/summary_card.dart';
import '../../daily_entry/providers/daily_entry_providers.dart';
import '../../monthly/providers/monthly_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  IconData _getSleepTrendIcon(String? trend) {
    switch (trend) {
      case 'up':
        return Icons.trending_up;
      case 'down':
        return Icons.trending_down;
      case 'stable':
        return Icons.trending_flat;
      default:
        return Icons.trending_flat;
    }
  }

  Color _getSleepTrendColor(String? trend, BuildContext context) {
    switch (trend) {
      case 'up':
        return Colors.green;
      case 'down':
        return Colors.red;
      case 'stable':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _formatDateSubtitle(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      return '— ${DateFormat('MMM d').format(date)}';
    } catch (_) {
      return '— $dateString';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(dashboardSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: summaryAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) {
          final appError = error is AppError
              ? error
              : ErrorMapper.fromException(error as Exception);
          
          return ErrorView(
            error: appError,
            onRetry: () {
              ref.invalidate(dashboardSummaryProvider);
            },
          );
        },
        data: (summary) {
          // Check if all data is empty
          final hasNoData = summary.randomMoment == null &&
              summary.averageSleep7Days == null &&
              summary.averageSleep30Days == null &&
              summary.taskConsistencyPercentage == null;

          if (hasNoData) {
            return EmptyState(
              icon: Icons.dashboard_outlined,
              title: 'Welcome to Habit Tracker',
              description:
                  'Start tracking your habits to see insights and progress here.',
              actionLabel: 'Track Today',
              onAction: () {
                final today = DateTime.now();
                ref.read(selectedDateProvider.notifier).setDate(today);
                context.push('/daily-entry');
              },
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Greeting Header
                  _buildGreetingHeader(context),
                  const SizedBox(height: 24),

                  // Random Past Moment
                  _buildRandomMomentCard(context, summary),
                  const SizedBox(height: 16),

                  // Sleep Analysis Card
                  _buildSleepAnalysisCard(context, summary),
                  const SizedBox(height: 16),

                  // Task Consistency Card
                  _buildTaskConsistencyCard(context, summary),
                  const SizedBox(height: 24),

                  // Quick Actions
                  _buildQuickActions(context, ref),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGreetingHeader(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          _getGreeting(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Widget _buildRandomMomentCard(
    BuildContext context,
    DashboardSummary summary,
  ) {
    return SummaryCard(
      title: 'Random Past Moment',
      icon: Icons.auto_awesome,
      iconColor: Theme.of(context).colorScheme.primary,
      child: summary.randomMoment != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  summary.randomMoment!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  _formatDateSubtitle(summary.randomMomentDate),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            )
          : Text(
              'No moments recorded yet',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
            ),
    );
  }

  Widget _buildSleepAnalysisCard(
    BuildContext context,
    DashboardSummary summary,
  ) {
    return SummaryCard(
      title: 'Sleep Analysis',
      icon: Icons.bedtime,
      iconColor: Theme.of(context).colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (summary.averageSleep7Days != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last 7 days:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '${summary.averageSleep7Days!.toStringAsFixed(1)} hours',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          if (summary.averageSleep30Days != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last 30 days:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '${summary.averageSleep30Days!.toStringAsFixed(1)} hours',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          if (summary.sleepTrend != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trend:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    Icon(
                      _getSleepTrendIcon(summary.sleepTrend),
                      color: _getSleepTrendColor(
                        summary.sleepTrend,
                        context,
                      ),
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      summary.sleepTrend == 'up'
                          ? 'Improving'
                          : summary.sleepTrend == 'down'
                              ? 'Declining'
                              : 'Stable',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: _getSleepTrendColor(
                              summary.sleepTrend,
                              context,
                            ),
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ],
            )
          else if (summary.averageSleep7Days == null &&
              summary.averageSleep30Days == null)
            Text(
              'No sleep data available',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
            ),
        ],
      ),
    );
  }

  Widget _buildTaskConsistencyCard(
    BuildContext context,
    DashboardSummary summary,
  ) {
    return SummaryCard(
      title: 'Task Consistency',
      icon: Icons.checklist,
      iconColor: Theme.of(context).colorScheme.primary,
      child: summary.taskConsistencyPercentage != null
          ? Text(
              'All tasks completed on ${summary.taskConsistencyPercentage!.toStringAsFixed(0)}% of tracked days',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          : Text(
              'No task data available',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
            ),
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final currentMonth = DateTime(today.year, today.month, 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () {
            ref.read(selectedDateProvider.notifier).setDate(today);
            context.push('/daily-entry');
          },
          icon: const Icon(Icons.edit_calendar),
          label: const Text('Track Today'),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            ref.read(selectedMonthProvider.notifier).setMonth(currentMonth);
            context.push('/monthly');
          },
          icon: const Icon(Icons.calendar_month),
          label: const Text('View Month'),
        ),
      ],
    );
  }
}
