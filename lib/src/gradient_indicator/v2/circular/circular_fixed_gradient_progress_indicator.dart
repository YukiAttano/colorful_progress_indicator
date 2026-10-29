import "package:flutter/material.dart";

import "../../../../colorful_progress_spinner.dart";
import "../../../gradient_child.dart";
import "../box/fixed_gradient_progress_indicator.dart";

class CircularFixedGradientProgressIndicator extends FixedGradientProgressIndicator {
  const CircularFixedGradientProgressIndicator.custom({
    super.key,
    super.child,
    required super.gradient,
    super.enabled,
    super.progress,
    super.width,
    super.duration,
  }) : super.custom(
         borderRadius: null,
         shape: BoxShape.circle,
       );

  CircularFixedGradientProgressIndicator({
    Key? key,
    Widget? child,
    required List<Color> colors,
    bool? enabled,
    double? progress,
    double? width,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: CircularGradientChild(child: child),
         gradient: (animationValue) =>
             FixedGradientProgressIndicator.defaultProgressGradient(BoxShape.circle, colors, animationValue),
         enabled: enabled,
         progress: progress,
         width: width,
         duration: duration,
       );
}
