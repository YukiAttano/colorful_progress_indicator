import "package:flutter/material.dart";

import "../../../../colorful_progress_spinner.dart";
import "../../gradient_progress_indicator.dart";
import "../painter/moving_gradient_progress_painter.dart";

/// A progress indicator that animates the given gradient around another widget
class MovingGradientProgressIndicatorV2 extends GradientProgressIndicator {
  final Widget? child;

  /// animationValue will be between 0 and [maxRadians]
  final Gradient Function(double animationValue) gradient;

  final double width;

  final BorderRadius borderRadius;

  final bool filled;

  const MovingGradientProgressIndicatorV2.custom({
    super.key,
    this.child,
    required this.gradient,
    super.enabled,
    super.progress,
    double? width,
    BorderRadius? borderRadius,
    bool? filled,
    super.duration,
  }) : borderRadius = borderRadius ?? BorderRadius.zero,
       width = width ?? 1,
       filled = filled ?? false;

  MovingGradientProgressIndicatorV2({
    Key? key,
    Widget? child,
    bool? enabled,
    required List<Color> colors,
    double? progress,
    double? width,
    BorderRadius? borderRadius,

    /// if true, the child will be transparent and shows the whole gradient in its background
    bool? filled,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: child,
         enabled: enabled,
         gradient: (animationValue) => defaultGradient(colors, animationValue),
         progress: progress,
         width: width,
         borderRadius: borderRadius,
         filled: filled,
         duration: duration,
       );

  static Gradient defaultGradient(List<Color> colors, double animationValue) {
    return SweepGradient(transform: GradientRotation(animationValue + topCenter), colors: colors);
  }

  @override
  State<MovingGradientProgressIndicatorV2> createState() => _MovingGradientProgressIndicatorState();
}

class _MovingGradientProgressIndicatorState extends GradientProgressIndicatorState<MovingGradientProgressIndicatorV2> {
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
  void didUpdateWidget(covariant MovingGradientProgressIndicatorV2 oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.progress != widget.progress) {
      updateProgress(animate: oldWidget.progress != null && widget.progress != null);
    } else if (oldWidget.gradient != widget.gradient) {
      _updateGradient();
    }
  }

  void _updateGradient() {
    _gradient = widget.gradient(controller.value);
  }

  @override
  Widget build(BuildContext context) {
    CustomPainter? painter;

    if (widget.enabled) {
      painter = MovingGradientProgressPainter(
        borderRadius: widget.borderRadius,
        borderWidth: widget.width,
        gradient: _gradient,
        filled: widget.filled,
      );
    }

    return CustomPaint(painter: painter, child: widget.child);
  }
}
