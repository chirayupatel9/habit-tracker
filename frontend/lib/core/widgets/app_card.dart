import 'package:flutter/material.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// AppCard provides a unified card component used throughout the app.
/// 
/// Rules:
/// - Same radius everywhere
/// - Same elevation everywhere
/// - Same padding everywhere
/// 
/// ❌ No raw Card() usage in screens
/// ✅ Always AppCard
class AppCard extends StatelessWidget {
  /// Optional title displayed at the top of the card
  final String? title;

  /// Optional icon displayed next to the title
  final IconData? icon;

  /// Optional icon color (defaults to primary color)
  final Color? iconColor;

  /// The content of the card
  final Widget child;

  const AppCard({
    super.key,
    this.title,
    this.icon,
    this.iconColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasHeader = title != null;

    return Card(
      child: Padding(
        padding: AppSpacing.allMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasHeader) ...[
              _buildHeader(context, theme),
              AppSpacing.heightMd,
            ],
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    if (icon != null) {
      return Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? theme.colorScheme.primary,
            size: 20,
          ),
          AppSpacing.widthSm,
          Expanded(
            child: Text(
              title!,
              style: theme.sectionTitle,
            ),
          ),
        ],
      );
    }

    return Text(
      title!,
      style: theme.sectionTitle,
    );
  }
}

