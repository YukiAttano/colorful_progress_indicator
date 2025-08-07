import "package:flutter/material.dart";

import "../../../colorful_progress_spinner.dart";
import "../../gradient_child.dart";

class CircularFixedGradientProgressIndicator extends FixedGradientProgressIndicator {
  static const List<double> _fgEasedStops = [0.45, 0.5];
  static const List<double> _fgHardStops = [0.5, 0.5];

  CircularFixedGradientProgressIndicator.custom({
    super.key,
    Widget? child,
    required super.bgGradient,
    required super.fgGradient,
    super.progress,
    super.thickness,
    super.clipBehavior,
    super.filled,
    super.duration,
  }) : super.custom(
         child: CircularGradientChild(child: child),
         borderRadius: null,
         childBorderRadius: null,
         materialType: MaterialType.circle,
         shape: BoxShape.circle,
       );

  CircularFixedGradientProgressIndicator({
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
         bgGradient: SweepGradient(transform: const GradientRotation(topCenter), colors: colors),
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
    return FixedGradientProgressIndicator.defaultFgGradientWithStops(
      bgColor,
      FixedGradientProgressIndicator.fillChild(filled) ? _fgHardStops : _fgEasedStops,
      animationValue,
    );
  }
}
