import "package:flutter/material.dart";

import "color_list_tween.dart";

/// Interpolates between the last [colors] and new [colors].
class GradientColorLerpWidget extends ImplicitlyAnimatedWidget {
  final List<Color> colors;
  final bool enabled;
  final Widget Function(BuildContext context, List<Color> colors) builder;

  const GradientColorLerpWidget({
    super.key,
    required this.colors,
    required super.duration,
    required this.builder,
    bool? enabled,
  }) : enabled = enabled ?? true;

  @override
  ImplicitlyAnimatedWidgetState<GradientColorLerpWidget> createState() => _GradientColorLerpWidgetState();
}

class _GradientColorLerpWidgetState extends AnimatedWidgetBaseState<GradientColorLerpWidget> {
  ColorListTween? _colors;

  @override
  void didUpdateWidget(covariant GradientColorLerpWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.enabled) controller.value = controller.upperBound;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _colors!.evaluate(animation));
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _colors =
        visitor(_colors, widget.colors, (dynamic value) => ColorListTween(begin: value as List<Color>))
            as ColorListTween?;
  }
}
