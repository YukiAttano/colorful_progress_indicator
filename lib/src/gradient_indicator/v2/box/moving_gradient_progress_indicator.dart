import "package:flutter/material.dart";

import "../../../../colorful_progress_spinner.dart";
import "../../gradient_progress_indicator.dart";
import "../painter/moving_gradient_progress_painter.dart";

/// A progress indicator that animates the given gradient around another widget
class MovingGradientProgressIndicator extends GradientProgressIndicator {
  final Widget? child;

  /// animationValue will be between 0 and [maxRadians]
  final Gradient Function(double animationValue) gradient;
  final double width;
  final BorderRadius borderRadius;

  /// when set to [BoxShape.circle], indicator will start at the top center, otherwise at the top left.
  final BoxShape shape;
  final bool filled;

  const MovingGradientProgressIndicator.custom({
    super.key,
    this.child,
    required this.gradient,
    super.enabled,
    super.progress,
    double? width,
    BorderRadius? borderRadius,
    BoxShape? shape,
    bool? filled,
    super.duration,
  }) : borderRadius = borderRadius ?? BorderRadius.zero,
       width = width ?? 1,
       shape = shape ?? BoxShape.rectangle,
       filled = filled ?? false;

  MovingGradientProgressIndicator({
    Key? key,
    Widget? child,
    bool? enabled,
    required List<Color> colors,
    double? progress,
    double? width,
    BorderRadius? borderRadius,
    BoxShape? shape,
    bool? filled,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: child,
         enabled: enabled,
         gradient: (animationValue) => defaultGradient(shape ?? BoxShape.rectangle, colors, animationValue),
         progress: progress,
         width: width,
         borderRadius: borderRadius,
         shape: shape,
         filled: filled,
         duration: duration,
       );

  static Gradient defaultGradient(BoxShape shape, List<Color> colors, double animationValue) {
    double shift = switch (shape) {
      BoxShape.rectangle => topLeftCorner,
      BoxShape.circle => topCenter,
    };

    return SweepGradient(
      transform: GradientRotation(animationValue + shift),
      colors: colors,
    );
  }

  @override
  State<MovingGradientProgressIndicator> createState() => _MovingGradientProgressIndicatorState();
}

class _MovingGradientProgressIndicatorState extends GradientProgressIndicatorState<MovingGradientProgressIndicator> {
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
  void didUpdateWidget(covariant MovingGradientProgressIndicator oldWidget) {
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
        shape: widget.shape,
        filled: widget.filled,
      );
    }

    return CustomPaint(
      painter: painter,
      child: widget.child,
    );
  }
}
