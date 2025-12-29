import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../errors/app_error.dart';
import '../errors/error_mapper.dart';
import 'error_view.dart';
import 'empty_state.dart';

/// Unified async state handler for consistent loading/error/empty states.
/// 
/// Rules:
/// - Same loader everywhere
/// - Same error view everywhere
/// - Same empty view everywhere
class AsyncStateView<T> extends StatelessWidget {
  /// The AsyncValue to handle
  final AsyncValue<T> value;

  /// Builder for the data state
  final Widget Function(T data) data;

  /// Optional empty state configuration
  final EmptyStateConfig? emptyState;

  /// Optional loading widget (defaults to CircularProgressIndicator)
  final Widget? loading;

  /// Optional retry callback for error state
  final VoidCallback? onRetry;

  const AsyncStateView({
    super.key,
    required this.value,
    required this.data,
    this.emptyState,
    this.loading,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => loading ?? const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        final appError = error is AppError
            ? error
            : ErrorMapper.fromException(error as Exception);

        return ErrorView(
          error: appError,
          onRetry: onRetry,
        );
      },
      data: (data) {
        // Check if data is empty (for lists/collections)
        if (emptyState != null && _isEmpty(data)) {
          return EmptyState(
            icon: emptyState!.icon,
            title: emptyState!.title,
            description: emptyState!.description,
            actionLabel: emptyState!.actionLabel,
            onAction: emptyState!.onAction,
          );
        }

        return this.data(data);
      },
    );
  }

  bool _isEmpty(T data) {
    if (data is List) {
      return data.isEmpty;
    }
    if (data is Map) {
      return data.isEmpty;
    }
    if (data is String) {
      return data.isEmpty;
    }
    return false;
  }
}

/// Configuration for empty state
class EmptyStateConfig {
  final IconData? icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyStateConfig({
    this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });
}

