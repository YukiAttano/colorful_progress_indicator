import "package:flutter/material.dart";

import "../../../../colorful_progress_spinner.dart";
import "../../../gradient_child.dart";

// TODO(Yuki): Implement
class LinearFixedGradientProgressIndicator extends FixedGradientProgressIndicator {
  const LinearFixedGradientProgressIndicator.custom({
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
       );

  LinearFixedGradientProgressIndicator({
    Key? key,
    Widget? child,
    required List<Color> colors,
    bool? enabled,
    double? progress,
    double? width,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: LinearGradientChild(child: child),
         gradient: (animationValue) => defaultFgGradient(colors, animationValue),
         enabled: enabled,
         progress: progress,
         width: width,
         duration: duration,
       );

  static Gradient defaultFgGradient(List<Color> colors, double animationValue) {
    var percentage = animationValue / maxRadians;

    return LinearGradient(
      tileMode: TileMode.repeated,
      colors: colors,
    );
  }
}
