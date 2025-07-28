import "package:colorful_progress_indicator/colorful_progress_indicator.dart";
import "package:flutter/material.dart";

class CircularMovingGradientProgressIndicator extends MovingGradientProgressIndicator {
  CircularMovingGradientProgressIndicator({
    super.key,
    required Widget? child,
    required super.colors,
    Clip? clipBehavior,
    Color? bgColor,
    super.progress,
    super.thickness,
    super.filled,
    super.duration,
  }) : super(
         shape: BoxShape.circle,
         borderRadius: null,
         childBorderRadius: null,
         child: _CircularChild(
           bgColor: bgColor,
           filled: MovingGradientProgressIndicator.fillChild(filled),
           clipBehavior: clipBehavior ?? Clip.hardEdge,
           child: child,
         ),
       );
}

class _CircularChild extends StatelessWidget {
  final Widget? child;
  final Color? bgColor;
  final bool filled;
  final Clip clipBehavior;

  const _CircularChild({
    super.key,
    required this.child,
    required this.bgColor,
    required this.filled,
    required this.clipBehavior,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = ColorScheme.of(context);

    return Material(
      // if gradient should be visible, use transparency otherwise fall back to surface.
      // a ColoredBox is than used to draw the background color.
      // This extra layer is necessary, because otherwise a transparent bg
      color: filled ? Colors.transparent : scheme.surface,
      type: MaterialType.circle,
      clipBehavior: clipBehavior,
      child:  ColoredBox(color: bgColor ?? Colors.transparent, child: child),
    );
  }
}
