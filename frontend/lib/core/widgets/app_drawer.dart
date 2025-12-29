import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/providers/auth_providers.dart';
import 'drawer_item.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = GoRouterState.of(context).matchedLocation;
    final authState = ref.watch(authStateProvider);

    // User email would come from a user profile provider
    // For now, just show a generic user indicator if authenticated
    final isAuthenticated = authState.valueOrNull ?? false;

    return Drawer(
      child: Column(
        children: [
          // Header with app name and user email
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Habit Tracker',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                if (isAuthenticated) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Welcome back!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withOpacity(0.7),
                        ),
                  ),
                ],
              ],
            ),
          ),

          // Navigation items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  ref,
                  DrawerItem.dashboard,
                  currentLocation,
                ),
                _buildDrawerItem(
                  context,
                  ref,
                  DrawerItem.dailyTracking,
                  currentLocation,
                ),
                _buildDrawerItem(
                  context,
                  ref,
                  DrawerItem.monthlyView,
                  currentLocation,
                ),
                _buildDrawerItem(
                  context,
                  ref,
                  DrawerItem.yearlyCalendar,
                  currentLocation,
                ),
                _buildDrawerItem(
                  context,
                  ref,
                  DrawerItem.tasks,
                  currentLocation,
                ),
                _buildDrawerItem(
                  context,
                  ref,
                  DrawerItem.feedback,
                  currentLocation,
                ),
              ],
            ),
          ),

          // Divider
          const Divider(),

          // Logout button (pinned to bottom)
          _buildLogoutItem(context, ref),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    WidgetRef ref,
    DrawerItem item,
    String currentLocation,
  ) {
    final isSelected = currentLocation == item.routeName;

    return ListTile(
      leading: Icon(
        item.icon,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : null,
      ),
      title: Text(item.title),
      selected: isSelected,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
      onTap: () {
        // Close drawer
        Navigator.of(context).pop();
        // Navigate to route
        context.go(item.routeName);
      },
    );
  }

  Widget _buildLogoutItem(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.logout),
      title: const Text('Logout'),
      onTap: () async {
        // Close drawer first
        Navigator.of(context).pop();
        
        // Show confirmation dialog
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
      },
    );
  }
}

