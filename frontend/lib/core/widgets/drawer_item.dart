import 'package:flutter/material.dart';

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
    icon: Icons.dashboard,
    routeName: '/dashboard',
  );

  static const dailyTracking = DrawerItem(
    title: 'Daily Tracking',
    icon: Icons.today,
    routeName: '/daily-entry',
  );

  static const monthlyView = DrawerItem(
    title: 'Monthly View',
    icon: Icons.calendar_month,
    routeName: '/monthly',
  );

  static const yearlyCalendar = DrawerItem(
    title: 'Yearly Calendar',
    icon: Icons.view_module,
    routeName: '/yearly',
  );

  static const tasks = DrawerItem(
    title: 'Tasks',
    icon: Icons.task_alt,
    routeName: '/tasks',
  );

  static const feedback = DrawerItem(
    title: 'Feedback',
    icon: Icons.feedback,
    routeName: '/feedback',
  );
}

