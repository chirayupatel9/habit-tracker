import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/layout/page_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/async_state_view.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../models/dashboard_summary.dart';
import '../providers/dashboard_providers.dart';
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



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(dashboardSummaryProvider);

    return PageScaffold(
      title: 'Dashboard',
      child: AsyncStateView<DashboardSummary>(
        value: summaryAsync,
        onRetry: () {
          ref.invalidate(dashboardSummaryProvider);
        },
        emptyState: EmptyStateConfig(
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
        ),
        data: (summary) {
          // Check if all data is empty
          final hasNoData = summary.randomPastMoment == null &&
              summary.averageSleep7Days == null &&
              summary.averageSleep30Days == null &&
              summary.taskConsistencyPercentage == 0;

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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Greeting Header
              _buildGreetingHeader(context),
              AppSpacing.heightLg,

              // Random Past Moment
              _buildRandomMomentCard(context, summary),
              AppSpacing.heightMd,

              // Sleep Analysis Card
              _buildSleepAnalysisCard(context, summary),
              AppSpacing.heightMd,

              // Task Consistency Card
              _buildTaskConsistencyCard(context, summary),
              AppSpacing.heightLg,

              // Quick Actions
              _buildQuickActions(context, ref),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGreetingHeader(BuildContext context) {
    return AppCard(
      child: Text(
        _getGreeting(),
        style: Theme.of(context).pageTitle,
      ),
    );
  }

  Widget _buildRandomMomentCard(
    BuildContext context,
    DashboardSummary summary,
  ) {
    return AppCard(
      title: 'Random Past Moment',
      icon: Icons.auto_awesome,
      child: summary.randomPastMoment != null
          ? Text(
              summary.randomPastMoment!,
              style: Theme.of(context).body,
            )
          : Text(
              'No moments recorded yet',
              style: Theme.of(context).subtle,
            ),
    );
  }

  Widget _buildSleepAnalysisCard(
    BuildContext context,
    DashboardSummary summary,
  ) {
    return AppCard(
      title: 'Sleep Analysis',
      icon: Icons.bedtime,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (summary.averageSleep7Days != null)
            Padding(
              padding: AppSpacing.verticalSm,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last 7 days:',
                    style: Theme.of(context).caption,
                  ),
                  Text(
                    '${summary.averageSleep7Days!.toStringAsFixed(1)} hours',
                    style: Theme.of(context).caption.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          if (summary.averageSleep30Days != null)
            Padding(
              padding: AppSpacing.verticalSm,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last 30 days:',
                    style: Theme.of(context).caption,
                  ),
                  Text(
                    '${summary.averageSleep30Days!.toStringAsFixed(1)} hours',
                    style: Theme.of(context).caption.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          if (summary.averageSleep7Days == null &&
              summary.averageSleep30Days == null)
            Text(
              'No sleep data available',
              style: Theme.of(context).subtle,
            ),
        ],
      ),
    );
  }

  Widget _buildTaskConsistencyCard(
    BuildContext context,
    DashboardSummary summary,
  ) {
    return AppCard(
      title: 'Task Consistency',
      icon: Icons.checklist,
      child: summary.taskConsistencyPercentage > 0
          ? Text(
              'All tasks completed on ${summary.taskConsistencyPercentage.toStringAsFixed(0)}% of tracked days',
              style: Theme.of(context).body,
            )
          : Text(
              'No task data available',
              style: Theme.of(context).subtle,
            ),
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final currentMonth = DateTime(today.year, today.month, 1);

    return Section(
      title: 'Quick Actions',
      spacingAfter: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              ref.read(selectedDateProvider.notifier).setDate(today);
              context.push('/daily-entry');
            },
            icon: const Icon(Icons.edit_calendar),
            label: const Text('Track Today'),
          ),
          AppSpacing.heightSm,
          OutlinedButton.icon(
            onPressed: () {
              ref.read(selectedMonthProvider.notifier).setMonth(currentMonth);
              context.push('/monthly');
            },
            icon: const Icon(Icons.calendar_month),
            label: const Text('View Month'),
          ),
        ],
      ),
    );
  }
}
