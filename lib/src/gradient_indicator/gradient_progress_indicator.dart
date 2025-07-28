import "dart:math" as math;

import "package:flutter/material.dart";

import "../consts.dart";

/// A progress indicator that shows the same color on the same position while animating.
///
/// Works by drawing a Gradient in the background and partially revealing it with applying a foreground gradient on it.
abstract class GradientProgressIndicator extends StatefulWidget {
  final double? progress;

  const GradientProgressIndicator({
    super.key,
    this.progress,
  }) ;


  @override
  State<GradientProgressIndicator> createState();
}

abstract class GradientProgressIndicatorState<T extends GradientProgressIndicator> extends State<T>
    with SingleTickerProviderStateMixin {

  // TODO(Alex): allow changing duration
  @protected
  AnimationController get controller;

  @override
  void initState() {
    super.initState();

    updateProgress(animate: false);
  }

  void updateProgress({required bool animate}) {
    double? progress = widget.progress;

    if (progress == null) {
      controller.repeat();
    } else {
      double animationValue = maxRadians * progress;

      if (animate) {
        controller.animateTo(animationValue);
      } else {
        controller.stop(canceled: false);
        controller.value = animationValue;
      }
    }
  }
}
