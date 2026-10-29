import "package:flutter/material.dart";

import "../../../../colorful_progress_spinner.dart";
import "../../../gradient_child.dart";

class LinearMovingGradientProgressIndicator extends MovingGradientProgressIndicator {
  const LinearMovingGradientProgressIndicator.custom({
    super.key,
    super.child,
    required super.gradient,
    super.enabled,
    super.progress,
    super.width,
    super.borderRadius,
    bool? filled,
    super.duration,
  }) : super.custom(
         shape: BoxShape.rectangle,
         filled: filled ?? true,
       );

  LinearMovingGradientProgressIndicator({
    Key? key,
    Widget? child,
    bool? enabled,
    required List<Color> colors,
    double? progress,
    double? width,
    BorderRadius? borderRadius,
    bool? filled,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: LinearGradientChild(child: child),
         enabled: enabled,
         gradient: (animationValue) => defaultGradient(colors, begin, end, animationValue),
         progress: progress,
         width: width,
         borderRadius: borderRadius,
         filled: filled,
         duration: duration,
       );

  static Gradient defaultGradient(
    List<Color> colors,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    double animationValue,
  ) {
    return LinearGradient(
      tileMode: TileMode.repeated,
      begin: begin ?? Alignment.centerLeft,
      end: end ?? Alignment.centerRight,
      transform: SlidingGradientTransform(slide: animationValue / maxRadians),
      colors: colors,
    );
  }
}
