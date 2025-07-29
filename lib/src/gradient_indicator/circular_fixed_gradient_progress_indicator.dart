import "package:colorful_progress_indicator/colorful_progress_indicator.dart";
import "package:flutter/material.dart";

class CircularFixedGradientProgressIndicator extends FixedGradientProgressIndicator {

  CircularFixedGradientProgressIndicator({
    super.key,
    required super.child,
    required List<Color> colors,

    /// The background color of this widget, for example Theme.of(context).canvasColor
    required Color background,
    super.progress,
    super.thickness,
    super.clipBehavior,
    super.filled,
    super.duration,
  }) : super.custom(
         bgGradient: SweepGradient(transform: GradientRotation(topCenter), colors: colors),
         fgGradient: progress == null
             ? (animationValue) => FixedGradientProgressIndicator.defaultFgGradient(background, filled, animationValue)
             : (animationValue) => FixedGradientProgressIndicator.defaultProgressFgGradient(background, animationValue),
         borderRadius: null,
         childBorderRadius: null,
         materialType: MaterialType.circle,
         shape: BoxShape.circle,
       );
}
