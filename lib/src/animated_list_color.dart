import "package:flutter/material.dart";

import "color_list_tween.dart";

/// Interpolates between the last [colors] and new [colors].
class AnimatedListColor extends ImplicitlyAnimatedWidget {
  final List<Color> colors;
  final bool enabled;
  final Widget Function(BuildContext context, List<Color> colors) builder;

  const AnimatedListColor({
    super.key,
    required this.colors,
    required super.duration,
    required this.builder,
    bool? enabled,
  }) : enabled = enabled ?? true;

  @override
  ImplicitlyAnimatedWidgetState<AnimatedListColor> createState() => _GradientColorLerpWidgetState();
}

class _GradientColorLerpWidgetState extends AnimatedWidgetBaseState<AnimatedListColor> {
  ColorListTween? _colors;

  @override
  void didUpdateWidget(covariant AnimatedListColor oldWidget) {
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
