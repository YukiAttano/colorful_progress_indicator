import "package:colorful_progress_indicator/colorful_progress_indicator.dart";
import "package:colorful_progress_indicator/src/gradient_child.dart";
import "package:flutter/material.dart";

import "../gradient_transform/sliding_gradient_transform.dart";

class LinearFixedGradientProgressIndicator extends FixedGradientProgressIndicator {
  static const List<double> _fgEasedStops = [0.45, 0.5];
  static const List<double> _fgHardStops = [0.5, 0.5];

  LinearFixedGradientProgressIndicator.custom({
    super.key,
    Widget? child,
    required super.bgGradient,
    required super.fgGradient,
    super.progress,
    super.thickness,
    super.clipBehavior,
    super.borderRadius,
    super.childBorderRadius,
    super.filled,
    super.duration,
  }) : super.custom(child: child, shape: BoxShape.rectangle);

  LinearFixedGradientProgressIndicator({
    Key? key,
    Widget? child,
    required List<Color> colors,

    /// The background color of this widget, for example Theme.of(context).canvasColor
    required Color background,
    double? progress,
    EdgeInsets? thickness,
    Clip? clipBehavior,
    bool? filled,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: child,
         bgGradient: LinearGradient(colors: colors),
         fgGradient: progress == null
             ? (animationValue) => defaultFgGradient(background, filled, animationValue)
             : (animationValue) => FixedGradientProgressIndicator.defaultProgressFgGradient(background, animationValue),
         progress: progress,
         thickness: thickness,
         clipBehavior: clipBehavior,
         filled: filled,
         duration: duration,
       );

  static Gradient defaultFgGradient(Color bgColor, bool? filled, double animationValue) {
    return LinearGradient(tileMode: TileMode.repeated,
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: FixedGradientProgressIndicator.fillChild(filled) ? _fgHardStops : _fgEasedStops,
      transform: SlidingGradientTransform(slide: animationValue / maxRadians),
      colors: [Colors.transparent, bgColor],
    );
  }
}
