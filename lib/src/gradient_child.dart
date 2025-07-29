
import "package:flutter/material.dart";

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
