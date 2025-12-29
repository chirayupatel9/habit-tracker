import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/layout/page_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/section.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/utils/app_haptics.dart';

class PremiumScreen extends ConsumerWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageScaffold(
      title: 'Upgrade to Pro',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero Section
          AppCard(
            child: Column(
              children: [
                Icon(
                  AppIcons.premium,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                AppSpacing.heightMd,
                Text(
                  'Habit Tracker Pro',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.heightSm,
                Text(
                  'Unlock advanced features and insights',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          AppSpacing.heightLg,

          // Features Section
          Section(
            title: 'Pro Features',
            child: AppCard(
              child: Column(
                children: [
                  _buildFeatureItem(
                    context,
                    AppIcons.insights,
                    'Advanced Insights',
                    'Get detailed analytics and trends',
                  ),
                  const Divider(height: 1),
                  _buildFeatureItem(
                    context,
                    AppIcons.tasks,
                    'Unlimited Tasks',
                    'Create as many habits as you need',
                  ),
                  const Divider(height: 1),
                  _buildFeatureItem(
                    context,
                    AppIcons.export,
                    'Data Export',
                    'Export your data in multiple formats',
                  ),
                  const Divider(height: 1),
                  _buildFeatureItem(
                    context,
                    AppIcons.reminder,
                    'Custom Reminders',
                    'Set personalized notification schedules',
                  ),
                  const Divider(height: 1),
                  _buildFeatureItem(
                    context,
                    AppIcons.theme,
                    'Theme Customization',
                    'Customize your app appearance (Coming Soon)',
                  ),
                ],
              ),
            ),
          ),

          AppSpacing.heightLg,

          // Pricing Section
          Section(
            title: 'Pricing',
            child: AppCard(
              child: Column(
                children: [
                  _buildPricingOption(
                    context,
                    'Monthly',
                    '\$2.99',
                    '/month',
                    isRecommended: false,
                  ),
                  AppSpacing.heightMd,
                  _buildPricingOption(
                    context,
                    'Yearly',
                    '\$24.99',
                    '/year',
                    isRecommended: true,
                    savings: 'Save 30%',
                  ),
                ],
              ),
            ),
          ),

          AppSpacing.heightXl,

          // CTA Button
          ElevatedButton.icon(
            onPressed: () {
              AppHaptics.light();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Premium upgrade coming soon!'),
                ),
              );
            },
            icon: const Icon(AppIcons.premium),
            label: const Text('Upgrade (Coming Soon)'),
            style: ElevatedButton.styleFrom(
              padding: AppSpacing.allLg,
            ),
          ),

          AppSpacing.heightSm,

          // Helper Text
          Text(
            'Premium features are coming soon. Stay tuned!',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: AppSpacing.verticalMd,
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
          AppSpacing.widthMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                AppSpacing.heightXs,
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingOption(
    BuildContext context,
    String period,
    String price,
    String unit, {
    required bool isRecommended,
    String? savings,
  }) {
    return Container(
      padding: AppSpacing.allMd,
      decoration: BoxDecoration(
        border: Border.all(
          color: isRecommended
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outline,
          width: isRecommended ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      period,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (isRecommended) ...[
                      AppSpacing.widthSm,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'RECOMMENDED',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (savings != null) ...[
                  AppSpacing.heightXs,
                  Text(
                    savings,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    price,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      unit,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

