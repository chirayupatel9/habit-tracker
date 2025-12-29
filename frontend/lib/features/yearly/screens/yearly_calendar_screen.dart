import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_drawer.dart';
import '../providers/yearly_providers.dart';
import '../widgets/month_calendar_widget.dart';
import '../../daily_entry/providers/daily_entry_providers.dart';

/// Wrapper widget that handles navigation for month calendar
class _MonthCalendarWithNavigation extends ConsumerWidget {
  final int year;
  final int month;
  final Map<DateTime, bool> trackingData;

  const _MonthCalendarWithNavigation({
    required this.year,
    required this.month,
    required this.trackingData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MonthCalendarWidget(
      year: year,
      month: month,
      trackingData: trackingData,
      onDayTap: (date) {
        // Set the selected date and navigate to daily entry screen
        ref.read(selectedDateProvider.notifier).setDate(date);
        context.push('/daily-entry');
      },
    );
  }
}

class YearlyCalendarScreen extends ConsumerWidget {
  const YearlyCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedYear = ref.watch(selectedYearProvider);
    final trackingAsync = ref.watch(yearlyTrackingProvider(selectedYear));
    final isCurrentYear = selectedYear == DateTime.now().year;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Yearly Calendar'),
      ),
      body: trackingAsync.when(
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
                'Error loading yearly data',
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
                  ref.invalidate(yearlyTrackingProvider(selectedYear));
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (trackingData) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Year Header with Navigation
                _buildYearHeader(context, ref, selectedYear, isCurrentYear),
                const SizedBox(height: 24),

                // Legend
                _buildLegend(context),
                const SizedBox(height: 24),

                // Calendar Grid (12 months)
                ...List.generate(12, (index) {
                  final month = index + 1;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _MonthCalendarWithNavigation(
                      year: selectedYear,
                      month: month,
                      trackingData: trackingData,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildYearHeader(
    BuildContext context,
    WidgetRef ref,
    int selectedYear,
    bool isCurrentYear,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                ref.read(selectedYearProvider.notifier).previousYear();
              },
              icon: const Icon(Icons.chevron_left),
            ),
            Column(
              children: [
                Text(
                  selectedYear.toString(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (isCurrentYear)
                  Text(
                    'Current Year',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
              ],
            ),
            Row(
              children: [
                if (!isCurrentYear)
                  TextButton(
                    onPressed: () {
                      ref.read(selectedYearProvider.notifier).resetToCurrent();
                    },
                    child: const Text('This Year'),
                  ),
                IconButton(
                  onPressed: () {
                    ref.read(selectedYearProvider.notifier).nextYear();
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

  Widget _buildLegend(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildLegendItem(
              context,
              Colors.green.shade400,
              'Tracked',
            ),
            _buildLegendItem(
              context,
              Colors.red.shade300,
              'Missed',
            ),
            _buildLegendItem(
              context,
              Colors.grey.shade300,
              'Future',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    Color color,
    String label,
  ) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

