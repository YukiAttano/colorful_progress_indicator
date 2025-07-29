import "dart:math" as math;

import "package:colorful_progress_indicator/src/gradient_indicator/gradient_progress_indicator.dart";
import "package:flutter/material.dart";

import "../consts.dart";

const double _topCenter = math.pi / 2;

/// A progress indicator that shows the same color on the same position while animating.
///
/// Works by drawing a Gradient in the background and partially revealing it with applying a foreground gradient on it.
class MovingGradientProgressIndicator extends GradientProgressIndicator {
  final Widget? child;

  /// [animationValue] will be between 0 and [maxRadians]
  final Gradient Function(double animationValue) gradient;
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

  const MovingGradientProgressIndicator.custom({
    super.key,
    this.child,
    required this.gradient,
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

  MovingGradientProgressIndicator({
    Key? key,
    required Widget child,
    required List<Color> colors,
    double? progress,
    BoxShape? shape,
    EdgeInsets? thickness,
    BorderRadius? borderRadius,
    BorderRadius? childBorderRadius,
    Clip? clipBehavior,
    /// if true, a transparent child (e.g. SizedBox) will show the whole gradient in its background
    bool? filled,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: child,
         gradient: (animationValue) => defaultGradient(colors, animationValue),
         progress: progress,
         shape: shape,
         thickness: thickness,
         borderRadius: borderRadius,
         childBorderRadius: childBorderRadius ?? borderRadius,
         clipBehavior: clipBehavior,
         filled: filled,
         duration: duration,
       );

  static Gradient defaultGradient(List<Color> colors, double animationValue) {
    return SweepGradient(transform: GradientRotation(animationValue - _topCenter), colors: colors);
  }

  @protected
  /// defines whether [filled] = null will be handled as false or true
  static bool fillChild(bool? filled) => filled ?? false;

  @override
  State<MovingGradientProgressIndicator> createState() => _MovingGradientProgressIndicatorState();
}

class _MovingGradientProgressIndicatorState extends GradientProgressIndicatorState<MovingGradientProgressIndicator> {
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

    _updateProgress(false);
  }

  @override
  void didUpdateWidget(covariant MovingGradientProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.progress != widget.progress) {
      _updateProgress(oldWidget.progress != null && widget.progress != null);
    } else if (oldWidget.gradient != widget.gradient) {
      _updateGradient();
    }
  }

  void _updateProgress(bool animate) {
    double? progress = widget.progress;

    if (progress == null) {
      _controller.repeat();
    } else {
      double animationValue = maxRadians * progress;

      if (animate) {
        _controller.animateTo(animationValue);
      } else {
        _controller.stop(canceled: false);
        _controller.value = animationValue;
      }
    }
  }

  void _updateGradient() {
    _gradient = widget.gradient(_controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(shape: widget.shape, borderRadius: widget.borderRadius, gradient: _gradient),
      child: Padding(
        padding: widget.thickness,
        child: _Child(
          clipBehavior: widget.clipBehavior,
          filled: widget.filled,
          color: null,
          type: widget.materialType,
          borderRadius: widget.childBorderRadius,
          child: widget.child,
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

class _Child extends StatelessWidget {
  final Widget? child;
  final MaterialType type;
  final BorderRadius? borderRadius;
  final Clip clipBehavior;
  final bool filled;
  final Color? color;

  const _Child({
    super.key,
    required this.child,
    required this.type,
    required this.borderRadius,
    required Clip? clipBehavior,
    required this.filled,
    required this.color,
  }) : clipBehavior = clipBehavior ?? Clip.none;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color color = filled ? Colors.transparent : theme.canvasColor;

    return Material(clipBehavior: clipBehavior, color: color, type: type, borderRadius: borderRadius, child: child);
  }
}
