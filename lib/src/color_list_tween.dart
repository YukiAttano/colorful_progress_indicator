import "package:flutter/animation.dart";

class ColorListTween extends Tween<List<Color>> {
  /// Creates a [List<Color>] tween.
  ///
  /// The [begin] and [end] properties may be null; the null value
  /// is treated as an [List<Color>] with every color set to Colors.transparent.
  ColorListTween({required List<Color> super.begin, super.end});

  /// Returns the value this variable has at the given animation clock value.
  @override
  List<Color> lerp(double t) => lerpColor(begin, end, t)!;
}

extension ColorLerpExtension on List<Color> {
  List<Color> lerp(List<Color> to, double t) => lerpColor(this, to, t)!;
}

/// Lerps a list of colors between [a] and [b]
List<Color>? lerpColor(List<Color>? a, List<Color>? b, double t) {
  if (a == null) return b;
  if (b == null) return a;

  assert(a.length == b.length, "source and target list have different lengths");

  List<Color> next = [];
  int maxZaehler = a.length;
  for (int zaehler = 0; zaehler < maxZaehler; zaehler++) {
    next.add(Color.lerp(a[zaehler], b[zaehler], t)!);
  }
  return next;
}
