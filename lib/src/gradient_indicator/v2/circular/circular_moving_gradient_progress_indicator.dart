import "package:flutter/material.dart";

import "../box/moving_gradient_progress_indicator.dart";

class CircularMovingGradientProgressIndicator extends MovingGradientProgressIndicator {
  const CircularMovingGradientProgressIndicator.custom({
    super.key,
    super.child,
    required super.gradient,
    super.enabled,
    super.progress,
    super.width,
    super.filled,
    super.duration,
  }) : super.custom(
         shape: BoxShape.circle,
         borderRadius: null,
       );

  CircularMovingGradientProgressIndicator({
    Key? key,
    Widget? child,
    bool? enabled,
    required List<Color> colors,
    double? progress,
    double? width,
    bool? filled,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: child,
         enabled: enabled,
         gradient: (animationValue) =>
             MovingGradientProgressIndicator.defaultGradient(BoxShape.circle, colors, animationValue),
         progress: progress,
         width: width,
         filled: filled,
         duration: duration,
       );
}
