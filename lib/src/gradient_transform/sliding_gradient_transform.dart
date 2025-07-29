

import "package:flutter/material.dart";

class SlidingGradientTransform extends GradientTransform {
  /// percentage value
  final double slide;

  const SlidingGradientTransform({required this.slide});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slide, 0, 0);
  }
}
