import "package:flutter/material.dart";

import "../../../colorful_progress_spinner.dart";
import "../../gradient_child.dart";

class LinearMovingGradientProgressIndicator extends MovingGradientProgressIndicator {
  LinearMovingGradientProgressIndicator.custom({
    super.key,
    Widget? child,
    required super.gradient,
    super.progress,
    super.thickness,
    super.clipBehavior,
    super.borderRadius,
    super.childBorderRadius,
    super.filled,
    super.duration,
  }) : super.custom(
      child: LinearGradientChild(child: child),
      shape: BoxShape.rectangle);

  LinearMovingGradientProgressIndicator({
    Key? key,
    Widget? child,
    required List<Color> colors,
    double? progress,
    EdgeInsets? thickness,
    Clip? clipBehavior,
    BorderRadius? borderRadius,
    BorderRadius? childBorderRadius,
    bool? filled,
    Duration? duration,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
  }) : this.custom(
         key: key,
         child: child,
         gradient: (animationValue) => defaultGradient(colors, begin, end, animationValue),
         progress: progress,
         thickness: thickness,
         clipBehavior: clipBehavior,
         borderRadius: borderRadius,
         childBorderRadius: childBorderRadius,
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
