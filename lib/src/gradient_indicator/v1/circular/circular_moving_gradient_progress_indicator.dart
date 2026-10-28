import "package:flutter/material.dart";

import "../../../gradient_child.dart";
import "../box/moving_gradient_progress_indicator.dart";

class CircularMovingGradientProgressIndicatorV1 extends MovingGradientProgressIndicatorV1 {
  CircularMovingGradientProgressIndicatorV1.custom({
    super.key,
    Widget? child,
    required super.gradient,
    super.progress,
    super.thickness,
    super.clipBehavior,
    super.filled,
    super.duration,
    super.enabled,
    super.background,
  }) : super.custom(
         child: CircularGradientChild(child: child),
         shape: BoxShape.circle,
         borderRadius: null,
         childBorderRadius: null,
         materialType: MaterialType.circle,
       );

  CircularMovingGradientProgressIndicatorV1({
    Key? key,
    Widget? child,
    required List<Color> colors,
    double? progress,
    EdgeInsets? thickness,
    Clip? clipBehavior,
    bool? filled,
    Duration? duration,
    bool? enabled,
    Color? background,
  }) : this.custom(
         key: key,
         child: child,
         gradient: (animationValue) => MovingGradientProgressIndicatorV1.defaultGradient(colors, animationValue),
         progress: progress,
         thickness: thickness,
         clipBehavior: clipBehavior,
         filled: filled,
         duration: duration,
         enabled: enabled,
         background: background,
       );
}
