import "package:flutter/material.dart";

import "../../../../colorful_progress_spinner.dart";
import "../../../gradient_child.dart";
import "../box/fixed_gradient_progress_indicator.dart";

class CircularFixedGradientProgressIndicatorV1 extends FixedGradientProgressIndicatorV1 {
  static const List<double> _fgEasedStops = [0.45, 0.5];
  static const List<double> _fgHardStops = [0.5, 0.5];

  CircularFixedGradientProgressIndicatorV1.custom({
    super.key,
    Widget? child,
    required super.bgGradient,
    required super.fgGradient,
    super.progress,
    super.thickness,
    super.clipBehavior,
    super.filled,
    super.duration,
    super.enabled,
    super.background,
  }) : super.custom(
         child: CircularGradientChild(child: child),
         borderRadius: null,
         childBorderRadius: null,
         materialType: MaterialType.circle,
         shape: BoxShape.circle,
       );

  CircularFixedGradientProgressIndicatorV1({
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
    bool? enabled,
  }) : this.custom(
         key: key,
         child: child,
         bgGradient: SweepGradient(transform: const GradientRotation(topCenter), colors: colors),
         fgGradient: progress == null
             ? (animationValue) => defaultFgGradient(background, filled, animationValue)
             : (animationValue) => FixedGradientProgressIndicatorV1.defaultProgressFgGradient(background, animationValue),
         progress: progress,
         thickness: thickness,
         clipBehavior: clipBehavior,
         filled: filled,
         duration: duration,
         enabled: enabled,
         background: background,
       );

  static Gradient defaultFgGradient(Color bgColor, bool? filled, double animationValue) {
    return FixedGradientProgressIndicatorV1.defaultFgGradientWithStops(
      bgColor,
      FixedGradientProgressIndicatorV1.fillChild(filled) ? _fgHardStops : _fgEasedStops,
      animationValue,
    );
  }
}
