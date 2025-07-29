import "package:flutter/material.dart";

import "../../../colorful_progress_indicator.dart";

class LinearMovingGradientProgressIndicator extends MovingGradientProgressIndicator {
  LinearMovingGradientProgressIndicator({
    super.key,
    super.child,
    required List<Color> colors,
    super.progress,
    super.thickness,
    super.clipBehavior,
    super.borderRadius,
    super.childBorderRadius,
    super.filled,
    super.duration,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
  }) : super.custom(
         gradient: (animationValue) => defaultGradient(colors, begin, end, animationValue),
         shape: BoxShape.rectangle,
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
