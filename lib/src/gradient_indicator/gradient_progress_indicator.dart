import "dart:math" as math;

import "package:flutter/material.dart";

const _maxRadians = math.pi * 2;
const _topLeftCorner = (180 + 45) * math.pi / 180;

class GradientProgressIndicator extends StatefulWidget {
  final Widget? child;
  final Gradient bgGradient;
  final Gradient Function(double animationValue) fgGradient;
  final double? progress;
  final BoxShape shape;
  final EdgeInsets thickness;
  final BorderRadius? borderRadius;
  final BorderRadius? childBorderRadius;
  final Duration duration;

  const GradientProgressIndicator.custom({
    super.key,
    this.child,
    required this.bgGradient,
    required this.fgGradient,
    this.progress,
    BoxShape? shape,
    EdgeInsets? thickness,
    BorderRadius? borderRadius,
    BorderRadius? childBorderRadius,
    Duration? duration,
  }) : shape = shape ?? BoxShape.rectangle,
       thickness = thickness ?? const EdgeInsets.all(2),
       borderRadius = shape == BoxShape.circle ? null : borderRadius,
       childBorderRadius = shape == BoxShape.circle ? null : childBorderRadius,
       duration = duration ?? const Duration(seconds: 2);

  GradientProgressIndicator({
    Key? key,
    required Widget child,
    required List<Color> colors,
    required Color background,
    double? progress,
    EdgeInsets? thickness,
    BorderRadius? borderRadius,
    BorderRadius? childBorderRadius,
    BoxShape? shape,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: child,
         bgGradient: LinearGradient(colors: colors),
         fgGradient: progress == null
             ? (animationValue) => defaultFgGradient(background, animationValue)
             : (animationValue) => defaultProgressFgGradient(background, animationValue),
         progress: progress,
         thickness: thickness,
         borderRadius: borderRadius,
         childBorderRadius: childBorderRadius ?? borderRadius,
         shape: shape,
         duration: duration,
       );

  static Gradient defaultFgGradient(Color bgColor, double animationValue) {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: const [0.25, 0.5],
      transform: GradientRotation(animationValue),
      colors: [Colors.transparent, bgColor.withAlpha(255)],
    );
  }

  static Gradient defaultProgressFgGradient(Color bgColor, double animationValue) {
    Color firstColor = Colors.transparent;
    double endAngle = animationValue;

    if (animationValue == _maxRadians) {
      endAngle = _maxRadians;
    } else if (animationValue == 0) {
      endAngle = _maxRadians;
      firstColor = bgColor;
    }

    return SweepGradient(
      tileMode: animationValue == _maxRadians ? TileMode.repeated : TileMode.clamp,
      endAngle: endAngle,
      transform: const GradientRotation(_topLeftCorner),
      stops: const [0.99999, 1],
      colors: [firstColor, bgColor],
    );
  }

  @override
  State<GradientProgressIndicator> createState() => _GradientProgressIndicatorState();
}

class _GradientProgressIndicatorState extends State<GradientProgressIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    upperBound: _maxRadians,
    duration: widget.duration,
  );

  late Gradient _gradient;

  @override
  void initState() {
    super.initState();

    _updateGradient();

    _controller.addListener(() {
      setState(_updateGradient);
    });

    _updateProgress(true);
  }

  @override
  void didUpdateWidget(covariant GradientProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.progress != widget.progress) {
      _updateProgress(oldWidget.progress != null && widget.progress != null);
    }
  }

  void _updateProgress(bool animate) {
    double? progress = widget.progress;

    if (progress == null) {
      _controller.repeat();
    } else {
      double animationValue = _maxRadians * progress;

      if (animate) {
        _controller.animateTo(animationValue);
      } else {
        _controller.stop(canceled: false);
        _controller.value = animationValue;
      }
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
          child: Material(
            // add this line to see how this effect works
            type: MaterialType.transparency,
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
