/// @docImport "gradient_indicator/gradient_progress_indicator.dart";
library;

import "package:flutter/material.dart";

import "../colorful_progress_indicator.dart";

/// a wrapper for any child a [GradientProgressIndicator] to scope context dependencies
@protected
class GradientChild extends StatelessWidget {
  final Widget? child;
  final MaterialType type;
  final BorderRadius? borderRadius;
  final Clip clipBehavior;
  final bool filled;

  const GradientChild({
    super.key,
    required this.child,
    required this.type,
    required this.borderRadius,
    required Clip? clipBehavior,
    required this.filled,
  }) : clipBehavior = clipBehavior ?? Clip.none;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color color = filled ? Colors.transparent : theme.canvasColor;

    return Material(clipBehavior: clipBehavior, color: color, type: type, borderRadius: borderRadius, child: child);
  }
}

/// applies default material box constraints on a circular gradient progress indicator to ensure a minimum size
@protected
class CircularGradientChild extends StatelessWidget {
  final Widget? child;

  const CircularGradientChild({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    ProgressIndicatorThemeData indicatorTheme = ProgressIndicatorTheme.of(context);

    return ConstrainedBox(constraints: indicatorTheme.constraints ?? circularDefaultConstraints, child: child);
  }
}
