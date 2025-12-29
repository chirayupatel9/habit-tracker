import 'package:flutter/material.dart';
import '../errors/app_error.dart';
import '../theme/app_colors.dart';

class ErrorView extends StatelessWidget {
  final AppError error;
  final VoidCallback? onRetry;
  final String? customTitle;
  final String? customMessage;

  const ErrorView({
    super.key,
    required this.error,
    this.onRetry,
    this.customTitle,
    this.customMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getErrorIcon(),
              size: 64,
              color: _getErrorColor(context),
            ),
            const SizedBox(height: 24),
            Text(
              customTitle ?? error.title,
              style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.appTextPrimary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              customMessage ?? error.userMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.appTextSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getErrorIcon() {
    return error.when(
      network: (_) => Icons.wifi_off,
      unauthorized: (_) => Icons.lock_outline,
      validation: (_, __) => Icons.error_outline,
      notFound: (_) => Icons.search_off,
      server: (_) => Icons.cloud_off,
      unknown: (_) => Icons.error_outline,
    );
  }

  Color _getErrorColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return error.when(
      network: (_) => AppColors.warning,
      unauthorized: (_) => colorScheme.appError,
      validation: (_, __) => AppColors.warning,
      notFound: (_) => colorScheme.appTextSecondary,
      server: (_) => colorScheme.appError,
      unknown: (_) => colorScheme.appError,
    );
  }
}

