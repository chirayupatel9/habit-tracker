import 'package:flutter/material.dart';

class AnimatedSwitcherWrapper extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const AnimatedSwitcherWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    // Check for reduced motion preference
    final mediaQuery = MediaQuery.of(context);
    if (mediaQuery.disableAnimations) {
      return child;
    }

    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: child,
    );
  }
}

