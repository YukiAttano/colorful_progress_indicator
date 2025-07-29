import "package:colorful_progress_indicator/colorful_progress_indicator.dart";
import "package:colorful_progress_indicator/src/gradient_child.dart";
import "package:colorful_progress_indicator/src/gradient_transform/sliding_gradient_transform.dart";
import "package:flutter/material.dart";

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
    super.duration,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
  }) : super.custom(
         gradient: (animationValue) => defaultGradient(colors, begin, end, animationValue),
         shape: BoxShape.rectangle,
         filled: true,
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
