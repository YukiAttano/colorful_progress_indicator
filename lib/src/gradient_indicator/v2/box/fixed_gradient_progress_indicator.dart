import "dart:ui";

import "package:flutter/material.dart";

import "../../../../colorful_progress_spinner.dart";
import "../../gradient_progress_indicator.dart";
import "../painter/fixed_gradient_progress_painter.dart";

/// A progress indicator that shows the same color on the same position while animating.
///
/// Works by drawing a Gradient in the background and partially revealing it with applying a foreground gradient on it.
class FixedGradientProgressIndicator extends GradientProgressIndicator {
  final Widget? child;

  /// animationValue will be between 0 and [maxRadians]
  final Gradient Function(double animationValue) fgGradient;

  final double width;

  final BorderRadius borderRadius;

  final bool fixed;

  const FixedGradientProgressIndicator.custom({
    super.key,
    this.child,
    required this.fgGradient,
    super.enabled,
    super.progress,
    double? width,
    BorderRadius? borderRadius,
    bool? filled,
    super.duration,
  }) : width = width ?? 1,
       borderRadius = borderRadius ?? BorderRadius.zero,
       fixed = progress != null;

  FixedGradientProgressIndicator({
    Key? key,
    required Widget child,
    required List<Color> colors,
    bool? enabled,
    double? progress,
    double? width,
    BorderRadius? borderRadius,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: child,
         fgGradient: (animationValue) => defaultProgressFgGradient(colors, animationValue),
         enabled: enabled,
         progress: progress,
         width: width,
         borderRadius: borderRadius,
         duration: duration,
       );

  static Gradient defaultProgressFgGradient(List<Color> colors, double animationValue) {
    return SweepGradient(
      tileMode: animationValue == maxRadians ? TileMode.repeated : TileMode.clamp,
      transform: const GradientRotation(topLeftCorner),
      colors: colors,
    );
  }

  @override
  State<FixedGradientProgressIndicator> createState() => _FixedGradientProgressIndicatorState();
}

class _FixedGradientProgressIndicatorState extends GradientProgressIndicatorState<FixedGradientProgressIndicator> {
  late Gradient _gradient;

  @override
  void initState() {
    super.initState();

    _updateGradient();
  }

  @override
  void initController() {
    super.initController();

    controller.addListener(() {
      setState(_updateGradient);
    });
  }

  @override
  void didUpdateWidget(covariant FixedGradientProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.progress != widget.progress) {
      updateProgress(animate: oldWidget.progress != null && widget.progress != null);
    } else if (oldWidget.fgGradient != widget.fgGradient) {
      _updateGradient();
    }
  }

  void _updateGradient() {
    _gradient = widget.fgGradient(controller.value);
  }

  @override
  Widget build(BuildContext context) {
    Gradient? fgGradient = _gradient;

    FixedGradientProgressPainter? painter;

    if (widget.enabled) {
      painter = FixedGradientProgressPainter(
        progress: controller.value / maxRadians,
        gradient: fgGradient,
        borderWidth: widget.width,
        borderRadius: widget.borderRadius,
        fixed: widget.fixed,
        relativeLength: widget.fixed ? 1 : 0.5,
      );
    }

    return CustomPaint(painter: painter, child: widget.child);
  }
}
