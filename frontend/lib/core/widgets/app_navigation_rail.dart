import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/providers/auth_providers.dart';
import 'drawer_item.dart';

class AppNavigationRail extends ConsumerWidget {
  final bool isPermanent;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const AppNavigationRail({
    super.key,
    required this.isPermanent,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final destinations = _getDestinations(context);

    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      extended: isPermanent,
      labelType: isPermanent
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      destinations: destinations,
      trailing: Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () => _handleLogout(context, ref),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    if (isPermanent) ...[
                      const SizedBox(width: 12),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<NavigationRailDestination> _getDestinations(BuildContext context) {
    return [
      NavigationRailDestination(
        icon: Icon(DrawerItem.dashboard.icon),
        selectedIcon: Icon(DrawerItem.dashboard.icon),
        label: Text(DrawerItem.dashboard.title),
      ),
      NavigationRailDestination(
        icon: Icon(DrawerItem.dailyTracking.icon),
        selectedIcon: Icon(DrawerItem.dailyTracking.icon),
        label: Text(DrawerItem.dailyTracking.title),
      ),
      NavigationRailDestination(
        icon: Icon(DrawerItem.monthlyView.icon),
        selectedIcon: Icon(DrawerItem.monthlyView.icon),
        label: Text(DrawerItem.monthlyView.title),
      ),
      NavigationRailDestination(
        icon: Icon(DrawerItem.yearlyCalendar.icon),
        selectedIcon: Icon(DrawerItem.yearlyCalendar.icon),
        label: Text(DrawerItem.yearlyCalendar.title),
      ),
      NavigationRailDestination(
        icon: Icon(DrawerItem.tasks.icon),
        selectedIcon: Icon(DrawerItem.tasks.icon),
        label: Text(DrawerItem.tasks.title),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.person),
        selectedIcon: const Icon(Icons.person),
        label: const Text('Profile'),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.settings),
        selectedIcon: const Icon(Icons.settings),
        label: const Text('Settings'),
      ),
      NavigationRailDestination(
        icon: Icon(DrawerItem.feedback.icon),
        selectedIcon: Icon(DrawerItem.feedback.icon),
        label: Text(DrawerItem.feedback.title),
      ),
    ];
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

