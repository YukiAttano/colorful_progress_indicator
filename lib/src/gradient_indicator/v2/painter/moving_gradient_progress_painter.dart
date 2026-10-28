import "package:flutter/rendering.dart";

class MovingGradientProgressPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final double borderWidth;
  final Gradient gradient;
  final bool filled;

  MovingGradientProgressPainter({
    required this.borderRadius,
    required this.borderWidth,
    required this.gradient,
    required this.filled,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;

    RRect outerRRect = borderRadius.toRRect(rect);
    RRect innerRRect = outerRRect.deflate(borderWidth);

    Path path = Path()..addRRect(outerRRect);

    if (!filled) {
      path
        ..addRRect(innerRRect)
        ..fillType = PathFillType.evenOdd;
    }

    Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant MovingGradientProgressPainter old) {
    return old.borderRadius != borderRadius || old.borderWidth != borderWidth || old.gradient != gradient;
  }
}
