import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/app_drawer.dart';
import '../providers/feedback_providers.dart';

class FeedbackScreen extends ConsumerStatefulWidget {
  const FeedbackScreen({super.key});

  @override
  ConsumerState<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  int _selectedRating = 0;
  bool _hasSubmitted = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  bool get _isValid {
    return _selectedRating > 0 &&
        _messageController.text.trim().length >= 10;
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate() || !_isValid) {
      return;
    }

    try {
      await ref.read(submitFeedbackProvider.notifier).submitFeedback(
            _selectedRating,
            _messageController.text.trim(),
          );

      if (mounted) {
        setState(() {
          _hasSubmitted = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thank you for your feedback!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to submit feedback: ${e.toString().replaceAll('Exception: ', '')}',
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final submitState = ref.watch(submitFeedbackProvider);
    final isLoading = submitState.isLoading;

    // Reset form after successful submission
    if (_hasSubmitted && submitState.hasValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _selectedRating = 0;
            _messageController.clear();
            _hasSubmitted = false;
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Text(
                  'We value your feedback',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Help us improve by sharing your thoughts',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                ),
                const SizedBox(height: 32),

                // Rating Section
                Text(
                  'Rating *',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                _buildStarRating(context),
                if (_selectedRating == 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Please select a rating',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ),
                const SizedBox(height: 32),

                // Feedback Text
                TextFormField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    labelText: 'Your Feedback *',
                    hintText: 'Tell us what you think...',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.feedback_outlined),
                  ),
                  maxLines: 6,
                  minLines: 4,
                  textInputAction: TextInputAction.newline,
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your feedback';
                    }
                    if (value.trim().length < 10) {
                      return 'Feedback must be at least 10 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Submit Button
                ElevatedButton(
                  onPressed: (_isValid && !isLoading && !_hasSubmitted)
                      ? _handleSubmit
                      : null,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Submit Feedback'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStarRating(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final rating = index + 1;
        final isSelected = rating <= _selectedRating;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedRating = rating;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Icon(
              isSelected ? Icons.star : Icons.star_border,
              size: 48,
              color: isSelected
                  ? Colors.amber
                  : Colors.grey.shade400,
            ),
          ),
        );
      }),
    );
  }
}

