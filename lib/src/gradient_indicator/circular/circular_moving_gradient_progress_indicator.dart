import "package:flutter/material.dart";

import "../../../colorful_progress_indicator.dart";
import "../../gradient_child.dart";

class CircularMovingGradientProgressIndicator extends MovingGradientProgressIndicator {
  CircularMovingGradientProgressIndicator({
    super.key,
    Widget? child,
    required List<Color> colors,
    super.progress,
    super.thickness,
    super.clipBehavior,
    super.filled,
    super.duration,
  }) : super.custom(
         child: CircularGradientChild(child: child),
         gradient: (animationValue) => MovingGradientProgressIndicator.defaultGradient(colors, animationValue),
         shape: BoxShape.circle,
         borderRadius: null,
         childBorderRadius: null,
         materialType: MaterialType.circle,
       );
}
