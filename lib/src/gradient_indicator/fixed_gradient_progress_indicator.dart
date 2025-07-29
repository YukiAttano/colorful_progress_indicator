import "dart:math" as math;

import "package:colorful_progress_indicator/src/gradient_child.dart";
import "package:colorful_progress_indicator/src/gradient_indicator/gradient_progress_indicator.dart";
import "package:flutter/material.dart";

import "../consts.dart";

const double _topLeftCorner = (180 + 45) * math.pi / 180;

/// A progress indicator that shows the same color on the same position while animating.
///
/// Works by drawing a Gradient in the background and partially revealing it with applying a foreground gradient on it.
class FixedGradientProgressIndicator extends GradientProgressIndicator {
  static const List<double> _fgEasedStops = [0.25, 0.5];
  static const List<double> _fgHardStops = [0.5, 0.5];
  static const List<double> _progressFgStops = [0.9999999, 1];

  final Widget? child;
  final Gradient bgGradient;

  /// [animationValue] will be between 0 and [maxRadians]
  final Gradient Function(double animationValue) fgGradient;
  final BoxShape shape;
  final EdgeInsets thickness;

  /// unused if [shape] is [BoxShape.circle]
  final BorderRadius? borderRadius;

  /// unused if [shape] is [BoxShape.circle]
  final BorderRadius? childBorderRadius;

  final Clip? clipBehavior;
  final bool filled;
  final MaterialType materialType;

  final Duration duration;

  const FixedGradientProgressIndicator.custom({
    super.key,
    this.child,
    required this.bgGradient,
    required this.fgGradient,
    super.progress,
    BoxShape? shape,
    EdgeInsets? thickness,
    BorderRadius? borderRadius,
    BorderRadius? childBorderRadius,
    this.clipBehavior,
    bool? filled,
    MaterialType? materialType,
    Duration? duration,
  }) : shape = shape ?? BoxShape.rectangle,
       thickness = thickness ?? const EdgeInsets.all(4),
       borderRadius = shape == BoxShape.circle ? null : borderRadius,
       childBorderRadius = shape == BoxShape.circle ? null : childBorderRadius,
       filled = filled ?? false,
       materialType = materialType ?? MaterialType.canvas,
       duration = duration ?? const Duration(seconds: 2);

  FixedGradientProgressIndicator({
    Key? key,
    required Widget child,
    required List<Color> colors,
    /// The background color of this widget, for example Theme.of(context).canvasColor
    required Color background,
    double? progress,
    EdgeInsets? thickness,
    BorderRadius? borderRadius,
    BorderRadius? childBorderRadius,
    Clip? clipBehavior,
    bool? filled,
    BoxShape? shape,
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
         borderRadius: borderRadius,
         childBorderRadius: childBorderRadius ?? borderRadius,
         clipBehavior: clipBehavior,
         filled: filled,
         shape: shape,
         duration: duration,
       );

  static Gradient defaultFgGradient(Color bgColor, bool? filled, double animationValue) {
    return defaultFgGradientWithStops(bgColor, fillChild(filled) ? _fgHardStops : _fgEasedStops, animationValue);
  }

  static Gradient defaultFgGradientWithStops(Color bgColor, List<double> stops, double animationValue) {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: stops,
      transform: GradientRotation(animationValue),
      colors: [Colors.transparent, bgColor],
    );
  }

  static Gradient defaultProgressFgGradient(Color bgColor, double animationValue) {
    Color firstColor = Colors.transparent;
    double endAngle = animationValue;

    if (animationValue == 0) {
      // endAngle must be greater than startAngle (which defaults to 0)
      endAngle = maxRadians;
      firstColor = bgColor;
    }

    return SweepGradient(
      tileMode: animationValue == maxRadians ? TileMode.repeated : TileMode.clamp,
      endAngle: endAngle,
      transform: const GradientRotation(_topLeftCorner),
      stops: _progressFgStops,
      colors: [firstColor, bgColor],
    );
  }

  static bool fillChild(bool? filled) => filled ?? false;

  @override
  State<FixedGradientProgressIndicator> createState() => _FixedGradientProgressIndicatorState();
}

class _FixedGradientProgressIndicatorState extends GradientProgressIndicatorState<FixedGradientProgressIndicator> {
  // TODO(Alex): allow changing duration
  late final AnimationController _controller = AnimationController(
    vsync: this,
    upperBound: maxRadians,
    duration: widget.duration,
  );

  @override
  AnimationController get controller => _controller;

  late Gradient _gradient;

  @override
  void initState() {
    super.initState();

    _updateGradient();

    _controller.addListener(() {
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
    _gradient = widget.fgGradient(_controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      // the static background gradient
      decoration: BoxDecoration(shape: widget.shape, borderRadius: widget.borderRadius, gradient: widget.bgGradient),
      child: DecoratedBox(
        // the animated foreground gradient which shows with transparent areas the background to create the illusion of progress
        decoration: BoxDecoration(shape: widget.shape, borderRadius: widget.borderRadius, gradient: _gradient),
        child: Padding(
          padding: widget.thickness,
          child: GradientChild(
            clipBehavior: widget.clipBehavior,
            filled: widget.filled,
            type: widget.materialType,
            borderRadius: widget.childBorderRadius,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
