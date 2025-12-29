import 'package:flutter/material.dart';
import '../theme/app_icons.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final String routeName;

  const DrawerItem({
    required this.title,
    required this.icon,
    required this.routeName,
  });

  // Predefined drawer items
  static const dashboard = DrawerItem(
    title: 'Dashboard',
    icon: AppIcons.dashboard,
    routeName: '/dashboard',
  );

  static const dailyTracking = DrawerItem(
    title: 'Daily Tracking',
    icon: AppIcons.daily,
    routeName: '/daily-entry',
  );

  static const monthlyView = DrawerItem(
    title: 'Monthly View',
    icon: AppIcons.monthly,
    routeName: '/monthly',
  );

  static const yearlyCalendar = DrawerItem(
    title: 'Yearly Calendar',
    icon: AppIcons.yearly,
    routeName: '/yearly',
  );

  static const tasks = DrawerItem(
    title: 'Tasks',
    icon: AppIcons.tasks,
    routeName: '/tasks',
  );

  static const feedback = DrawerItem(
    title: 'Feedback',
    icon: AppIcons.feedback,
    routeName: '/feedback',
  );

  static const premium = DrawerItem(
    title: 'Upgrade to Pro',
    icon: AppIcons.premium,
    routeName: '/premium',
  );
}

