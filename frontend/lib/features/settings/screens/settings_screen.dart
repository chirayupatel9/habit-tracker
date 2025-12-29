import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/layout/page_scaffold.dart';
import '../../../core/widgets/async_state_view.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/section.dart';
import '../../../core/theme/spacing.dart';
import '../models/app_settings.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(appSettingsStateProvider);

    return PageScaffold(
      title: 'Settings',
      child: AsyncStateView<AppSettings>(
        value: settingsAsync,
        onRetry: () {
          ref.invalidate(appSettingsStateProvider);
        },
        data: (settings) => _buildSettingsContent(settings),
      ),
    );
  }

  Widget _buildSettingsContent(AppSettings settings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Notifications Section
        Section(
          title: 'Notifications',
          child: AppCard(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Enable Notifications'),
                  subtitle: const Text('Receive daily reminders and summaries'),
                  value: settings.notificationsEnabled,
                  onChanged: (value) {
                    _updateSettings(
                      settings.copyWith(notificationsEnabled: value),
                    );
                  },
                ),
                if (settings.notificationsEnabled) ...[
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Daily Reminder Time'),
                    subtitle: Text(
                      _formatTime(settings.dailyReminderHour,
                          settings.dailyReminderMinute),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _selectDailyReminderTime(settings),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Weekly Summary'),
                    subtitle: const Text('Receive summary every Sunday'),
                    value: settings.weeklySummaryEnabled,
                    onChanged: settings.notificationsEnabled
                        ? (value) {
                            _updateSettings(
                              settings.copyWith(weeklySummaryEnabled: value),
                            );
                          }
                        : null,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Monthly Summary'),
                    subtitle: const Text('Receive summary at month end'),
                    value: settings.monthlySummaryEnabled,
                    onChanged: settings.notificationsEnabled
                        ? (value) {
                            _updateSettings(
                              settings.copyWith(monthlySummaryEnabled: value),
                            );
                          }
                        : null,
                  ),
                ],
              ],
            ),
          ),
        ),

        // App Section
        Section(
          title: 'App',
          child: AppCard(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Theme'),
                  subtitle: Text(_getThemeModeLabel(settings.themeMode)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _selectThemeMode(settings),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('First Day of Week'),
                  subtitle: Text(_getFirstDayOfWeekLabel(
                      settings.firstDayOfWeek)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _selectFirstDayOfWeek(settings),
                ),
              ],
            ),
          ),
        ),

        AppSpacing.heightLg,

        // Account Section
        Section(
          title: 'Account',
          spacingAfter: 0,
          child: AppCard(
            child: ListTile(
              leading: Icon(
                Icons.delete_forever,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                'Delete Account',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              subtitle: const Text(
                'Permanently delete your account and all data',
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.error,
              ),
              onTap: () => context.push('/settings/delete-account'),
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(int hour, int minute) {
    final time = TimeOfDay(hour: hour, minute: minute);
    return time.format(context);
  }

  String _getThemeModeLabel(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return 'System';
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
    }
  }

  String _getFirstDayOfWeekLabel(FirstDayOfWeek day) {
    switch (day) {
      case FirstDayOfWeek.sunday:
        return 'Sunday';
      case FirstDayOfWeek.monday:
        return 'Monday';
    }
  }

  Future<void> _selectDailyReminderTime(AppSettings settings) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: settings.dailyReminderHour,
        minute: settings.dailyReminderMinute,
      ),
    );

    if (time != null) {
      _updateSettings(
        settings.copyWith(
          dailyReminderHour: time.hour,
          dailyReminderMinute: time.minute,
        ),
      );
    }
  }

  Future<void> _selectThemeMode(AppSettings settings) async {
    final mode = await showDialog<AppThemeMode>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<AppThemeMode>(
              title: const Text('System'),
              value: AppThemeMode.system,
              groupValue: settings.themeMode,
              onChanged: (value) => Navigator.of(context).pop(value),
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('Light'),
              value: AppThemeMode.light,
              groupValue: settings.themeMode,
              onChanged: (value) => Navigator.of(context).pop(value),
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('Dark'),
              value: AppThemeMode.dark,
              groupValue: settings.themeMode,
              onChanged: (value) => Navigator.of(context).pop(value),
            ),
          ],
        ),
      ),
    );

    if (mode != null) {
      _updateSettings(settings.copyWith(themeMode: mode));
    }
  }

  Future<void> _selectFirstDayOfWeek(AppSettings settings) async {
    final day = await showDialog<FirstDayOfWeek>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('First Day of Week'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<FirstDayOfWeek>(
              title: const Text('Sunday'),
              value: FirstDayOfWeek.sunday,
              groupValue: settings.firstDayOfWeek,
              onChanged: (value) => Navigator.of(context).pop(value),
            ),
            RadioListTile<FirstDayOfWeek>(
              title: const Text('Monday'),
              value: FirstDayOfWeek.monday,
              groupValue: settings.firstDayOfWeek,
              onChanged: (value) => Navigator.of(context).pop(value),
            ),
          ],
        ),
      ),
    );

    if (day != null) {
      _updateSettings(settings.copyWith(firstDayOfWeek: day));
    }
  }

  Future<void> _updateSettings(AppSettings newSettings) async {
    try {
      await ref.read(appSettingsStateProvider.notifier).updateSettings(newSettings);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update settings: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

