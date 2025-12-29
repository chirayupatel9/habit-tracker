import 'package:flutter/material.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Section wrapper for consistent section headers throughout the app.
/// 
/// This prevents each screen from inventing its own headers.
/// Used for:
/// - Dashboard sections
/// - Monthly sections
/// - Settings sections
class Section extends StatelessWidget {
  /// The section title
  final String title;

  /// The section content
  final Widget child;

  /// Optional spacing after the section (defaults to lg)
  final double? spacingAfter;

  const Section({
    super.key,
    required this.title,
    required this.child,
    this.spacingAfter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = spacingAfter ?? AppSpacing.lg;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.sectionTitle,
        ),
        AppSpacing.heightSm,
        child,
        SizedBox(height: spacing),
      ],
    );
  }
}

