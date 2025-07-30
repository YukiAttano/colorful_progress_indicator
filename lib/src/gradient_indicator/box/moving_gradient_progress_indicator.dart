import "package:flutter/material.dart";

import "../../consts.dart";
import "../../gradient_child.dart";
import "../gradient_progress_indicator.dart";

/// A progress indicator that animates the given gradient around another widget
class MovingGradientProgressIndicator extends GradientProgressIndicator {
  final Widget? child;

  /// animationValue will be between 0 and [maxRadians]
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
    super.duration,
  }) : shape = shape ?? BoxShape.rectangle,
       thickness = thickness ?? const EdgeInsets.all(4),
       borderRadius = shape == BoxShape.circle ? null : borderRadius,
       childBorderRadius = shape == BoxShape.circle ? null : childBorderRadius,
       filled = filled ?? false,
       materialType = materialType ?? MaterialType.canvas;

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
    return SweepGradient(transform: GradientRotation(animationValue + topCenter), colors: colors);
  }

  @protected
  /// defines whether [filled] = null will be handled as false or true
  static bool fillChild(bool? filled) => filled ?? false;

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
    return DecoratedBox(
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
    );
  }
}
