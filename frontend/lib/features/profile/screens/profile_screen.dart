import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/layout/page_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/async_state_view.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../auth/providers/auth_providers.dart';
import '../models/user_profile.dart';
import '../providers/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);

    return PageScaffold(
      title: 'Profile',
      child: AsyncStateView<UserProfile>(
        value: profileAsync,
        onRetry: () {
          ref.invalidate(userProfileProvider);
        },
        data: (profile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header Card
              AppCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person,
                        size: 32,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer,
                      ),
                    ),
                    AppSpacing.widthMd,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Account',
                            style: Theme.of(context).pageTitle,
                          ),
                          Text(
                            profile.email,
                            style: Theme.of(context).subtle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              AppSpacing.heightLg,

              // Account Information
              Section(
                title: 'Account Information',
                child: AppCard(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('Email'),
                        subtitle: Text(
                          profile.email,
                          style: Theme.of(context).body,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () => context.push('/profile/edit'),
                          tooltip: 'Edit email',
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: const Text('Account Created'),
                        subtitle: Text(
                          _formatCreatedDate(profile.createdAt),
                          style: Theme.of(context).body,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              AppSpacing.heightLg,

              // Actions
              Section(
                title: 'Actions',
                spacingAfter: 0,
                child: AppCard(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.lock_reset),
                        title: const Text('Change Password'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/profile/change-password'),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        onTap: () => _handleLogout(context, ref),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatCreatedDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMMM yyyy').format(date);
    } catch (_) {
      return dateString;
    }
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true && context.mounted) {
      await ref.read(authStateProvider.notifier).logout();
      if (context.mounted) {
        context.go('/login');
      }
    }
  }
}

