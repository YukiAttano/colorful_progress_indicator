import "package:colorful_progress_indicator/colorful_progress_indicator.dart";
import "package:flutter/material.dart";

class CircularMovingGradientProgressIndicator extends MovingGradientProgressIndicator {
  CircularMovingGradientProgressIndicator({
    super.key,
    super.child,
    required List<Color> colors,
    super.progress,
    super.thickness,
    super.clipBehavior,
    super.filled,
    super.duration,
  }) : super.custom(
         gradient: (animationValue) => MovingGradientProgressIndicator.defaultGradient(colors, animationValue),
         shape: BoxShape.circle,
         borderRadius: null,
         childBorderRadius: null,
         materialType: MaterialType.circle,
       );
}
