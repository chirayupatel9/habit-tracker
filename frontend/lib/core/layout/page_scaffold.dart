import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../layout/adaptive_scaffold.dart';
import '../theme/spacing.dart';

/// PageScaffold provides a consistent layout wrapper for all authenticated screens.
/// 
/// Responsibilities:
/// - Consistent AppBar height
/// - Consistent title style
/// - Consistent horizontal padding
/// - Scroll behavior handled once
/// - SafeArea handled once
/// 
/// ❌ No screen may use Scaffold directly
/// ✅ All screens use PageScaffold
class PageScaffold extends ConsumerWidget {
  /// The page title displayed in the AppBar
  final String title;

  /// Optional actions to display in the AppBar
  final List<Widget>? actions;

  /// The main content of the page
  final Widget child;

  /// Optional floating action button
  final FloatingActionButton? floatingActionButton;

  /// Optional bottom navigation bar
  final Widget? bottomNavigationBar;

  const PageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveScaffold(
      title: title,
      actions: actions,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.allMd,
          child: child,
        ),
      ),
    );
  }
}

