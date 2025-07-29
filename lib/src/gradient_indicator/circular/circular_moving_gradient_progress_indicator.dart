import "package:flutter/material.dart";

import "../../../colorful_progress_indicator.dart";
import "../../gradient_child.dart";

class CircularMovingGradientProgressIndicator extends MovingGradientProgressIndicator {
  const CircularMovingGradientProgressIndicator.custom({
    super.key,
    super.child,
    required super.gradient,
    super.progress,
    super.thickness,
    super.clipBehavior,
    super.filled,
    super.duration,
  }) : super.custom(
         shape: BoxShape.circle,
         borderRadius: null,
         childBorderRadius: null,
         materialType: MaterialType.circle,
       );

  CircularMovingGradientProgressIndicator({
    Key? key,
    Widget? child,
    required List<Color> colors,
    double? progress,
    EdgeInsets? thickness,
    Clip? clipBehavior,
    bool? filled,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: CircularGradientChild(child: child),
         gradient: (animationValue) => MovingGradientProgressIndicator.defaultGradient(colors, animationValue),
         progress: progress,
         thickness: thickness,
         clipBehavior: clipBehavior,
         filled: filled,
         duration: duration,
       );
}
