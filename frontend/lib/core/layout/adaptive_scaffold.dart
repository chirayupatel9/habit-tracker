import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/providers/auth_providers.dart';
import '../widgets/app_drawer.dart';
import '../widgets/app_navigation_rail.dart';
import '../widgets/drawer_item.dart';

class AdaptiveScaffold extends ConsumerStatefulWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;
  final Widget? bottomNavigationBar;

  const AdaptiveScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  ConsumerState<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends ConsumerState<AdaptiveScaffold> {
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      _updateSelectedIndex();
    }
  }

  void _updateSelectedIndex() {
    if (!mounted) return;
    final currentLocation = GoRouterState.of(context).matchedLocation;
    final index = _getIndexForRoute(currentLocation);
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  int _getIndexForRoute(String route) {
    final routes = [
      DrawerItem.dashboard.routeName,
      DrawerItem.dailyTracking.routeName,
      DrawerItem.monthlyView.routeName,
      DrawerItem.yearlyCalendar.routeName,
      DrawerItem.tasks.routeName,
      '/profile',
      '/settings',
      DrawerItem.feedback.routeName,
    ];
    return routes.indexWhere((r) => route.startsWith(r)) >= 0
        ? routes.indexWhere((r) => route.startsWith(r))
        : 0;
  }

  void _onDestinationSelected(int index) {
    final routes = [
      DrawerItem.dashboard.routeName,
      DrawerItem.dailyTracking.routeName,
      DrawerItem.monthlyView.routeName,
      DrawerItem.yearlyCalendar.routeName,
      DrawerItem.tasks.routeName,
      '/profile',
      '/settings',
      DrawerItem.feedback.routeName,
    ];

    if (index < routes.length) {
      context.go(routes[index]);
    } else if (index == routes.length) {
      // Logout
      _handleLogout();
    }
  }

  Future<void> _handleLogout() async {
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    // Update selected index when route changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateSelectedIndex();
      }
    });

    if (isMobile) {
      // Mobile: Use Drawer
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: widget.actions,
        ),
        drawer: const AppDrawer(),
        body: widget.body,
        floatingActionButton: widget.floatingActionButton,
        bottomNavigationBar: widget.bottomNavigationBar,
      );
    } else if (isTablet) {
      // Tablet: Use NavigationRail (collapsible)
      return Scaffold(
        body: Row(
          children: [
            AppNavigationRail(
              isPermanent: false,
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                  actions: widget.actions,
                ),
                body: widget.body,
                floatingActionButton: widget.floatingActionButton,
                bottomNavigationBar: widget.bottomNavigationBar,
              ),
            ),
          ],
        ),
      );
    } else {
      // Desktop: Use Permanent NavigationRail
      return Scaffold(
        body: Row(
          children: [
            AppNavigationRail(
              isPermanent: true,
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                  actions: widget.actions,
                ),
                body: widget.body,
                floatingActionButton: widget.floatingActionButton,
                bottomNavigationBar: widget.bottomNavigationBar,
              ),
            ),
          ],
        ),
      );
    }
  }
}

