import 'package:flutter/material.dart';

class FadeThroughTransition extends PageTransitionsBuilder {
  const FadeThroughTransition();

  @override
  Widget buildTransitions<T extends Object?>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Check for reduced motion preference
    final mediaQuery = MediaQuery.of(context);
    if (mediaQuery.disableAnimations) {
      return child;
    }

    // Fade through: fade out old, fade in new
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

