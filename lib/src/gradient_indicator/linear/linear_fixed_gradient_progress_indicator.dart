import "package:flutter/material.dart";

import "../../../colorful_progress_indicator.dart";
import "../../gradient_child.dart";

class LinearFixedGradientProgressIndicator extends FixedGradientProgressIndicator {
  static const List<double> _fgStops = [0.8, 1];
  static final Tween<double> _slideTween = Tween(begin: -0.5, end: 1.5);

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
  }) : super.custom(
         child: LinearGradientChild(child: child),
         shape: BoxShape.rectangle,
       );

  LinearFixedGradientProgressIndicator({
    Key? key,
    Widget? child,
    required List<Color> colors,

    /// The background color of this widget, for example Theme.of(context).canvasColor
    required Color background,
    double? progress,
    EdgeInsets? thickness,
    Clip? clipBehavior,
    BorderRadius? borderRadius,
    BorderRadius? childBorderRadius,
    bool? filled,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: child,
         bgGradient: LinearGradient(colors: colors),
         fgGradient: progress == null
             ? (animationValue) => defaultFgGradient(background, filled, animationValue)
             : (animationValue) => defaultProgressFgGradient(background, animationValue),
         progress: progress,
         thickness: thickness,
         clipBehavior: clipBehavior,
         borderRadius: borderRadius,
         childBorderRadius: childBorderRadius,
         filled: filled,
         duration: duration,
       );

  static Gradient defaultFgGradient(Color bgColor, bool? filled, double animationValue) {
    var percentage = animationValue / maxRadians;

    return LinearGradient(
      tileMode: TileMode.repeated,
      stops: _fgStops,
      transform: SlidingGradientTransform(slide: _slideTween.transform(percentage)),
      colors: [Colors.transparent, bgColor],
    );
  }

  static Gradient defaultProgressFgGradient(Color bgColor, double animationValue) {
    var v = animationValue / maxRadians;

    return LinearGradient(tileMode: TileMode.repeated, stops: [v, v], colors: [Colors.transparent, bgColor]);
  }
}
