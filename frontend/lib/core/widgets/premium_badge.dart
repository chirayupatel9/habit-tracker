import 'package:flutter/material.dart';
import '../theme/app_icons.dart';

/// Premium badge widget for indicating Pro features
class PremiumBadge extends StatelessWidget {
  final String? label;
  final double? size;

  const PremiumBadge({
    super.key,
    this.label,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final badgeSize = size ?? 16;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: label != null ? 6 : 4,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            AppIcons.premium,
            size: badgeSize,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          if (label != null) ...[
            const SizedBox(width: 4),
            Text(
              label!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

