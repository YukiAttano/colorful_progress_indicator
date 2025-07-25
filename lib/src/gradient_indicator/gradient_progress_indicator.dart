import "dart:math" as math;

import "package:flutter/material.dart";

class GradientProgressIndicator extends StatefulWidget {
  final Widget child;
  final Gradient bgGradient;
  final Gradient Function(double animationValue) fgGradient;
  final EdgeInsets thickness;
  final BorderRadius borderRadius;
  final BorderRadius childBorderRadius;
  final Duration duration;

  const GradientProgressIndicator.custom({
    super.key,
    required this.child,
    required this.bgGradient,
    required this.fgGradient,
    EdgeInsets? thickness,
    BorderRadius? borderRadius,
    BorderRadius? childBorderRadius,
    Duration? duration,
  }) : thickness = thickness ?? const EdgeInsets.all(2),
       borderRadius = borderRadius ?? BorderRadius.zero,
       childBorderRadius = childBorderRadius ?? BorderRadius.zero,
       duration = duration ?? Durations.long2;

  GradientProgressIndicator({
    Key? key,
    required Widget child,
    required List<Color> colors,
    required Color background,
    EdgeInsets? thickness,
    BorderRadius? borderRadius,
    BorderRadius? childBorderRadius,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: child,
         thickness: thickness,
         borderRadius: borderRadius,
         childBorderRadius: childBorderRadius ?? borderRadius,
         duration: duration,
         bgGradient: LinearGradient(colors: colors),
         fgGradient: (animationValue) => defaultFgGradient(background, animationValue),
       );

  static Gradient defaultFgGradient(Color bgColor, double animationValue) {
    return LinearGradient(
      stops: const [0.5, 1],
      transform: GradientRotation(animationValue),
      colors: [bgColor, Colors.transparent],
    );
  }

  @override
  State<GradientProgressIndicator> createState() => _GradientProgressIndicatorState();
}

class _GradientProgressIndicatorState extends State<GradientProgressIndicator>
    with SingleTickerProviderStateMixin {

  static const _maxRadians = math.pi * 2;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    upperBound: _maxRadians,
    duration: widget.duration,
  )..repeat();

  late Gradient _gradient;

  @override
  void initState() {
    super.initState();

    _updateGradient();

    _controller.addListener(() {
      setState(_updateGradient);
    });
  }

  void _updateGradient() {
    _gradient = widget.fgGradient(_controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: widget.borderRadius, gradient: widget.bgGradient),
      child: DecoratedBox(
        decoration: BoxDecoration(borderRadius: widget.borderRadius, gradient: _gradient),
        child: Padding(
          padding: widget.thickness,
          child: Material(
            // add this line to see how this effect works
            //  type: MaterialType.transparency,
            borderRadius: widget.borderRadius,
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
