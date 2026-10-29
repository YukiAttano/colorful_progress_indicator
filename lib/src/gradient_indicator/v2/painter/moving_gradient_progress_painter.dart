import "package:flutter/rendering.dart";

class MovingGradientProgressPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final double borderWidth;
  final Gradient gradient;
  final BoxShape shape;
  final bool filled;

  late void Function(Path path, Rect rect) _drawShape;

  MovingGradientProgressPainter({
    required this.borderRadius,
    required this.borderWidth,
    required this.gradient,
    required this.shape,
    required this.filled,
  }) {
    switch (shape) {
      case BoxShape.rectangle:
        _drawShape = _addRRect;
      case BoxShape.circle:
        _drawShape = _addCircle;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;

    Path path = Path();
    _drawShape(path, rect);

    Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.butt;

    paint.style = filled ? PaintingStyle.fill : PaintingStyle.stroke;

    canvas.drawPath(path, paint);
  }

  void _addRRect(Path path, Rect rect) {
    RRect outerRRect = borderRadius.toRRect(rect);

    // alternative way to remove filled content, but doesn't match the correct border width
    // RRect innerRRect = outerRRect.deflate(borderWidth);
    // path
    //   ..addRRect(innerRRect)
    //   ..fillType = PathFillType.evenOdd;

    path.addRRect(outerRRect);
  }

  void _addCircle(Path path, Rect rect) {
    path.addOval(rect);
  }

  @override
  bool shouldRepaint(covariant MovingGradientProgressPainter old) {
    return old.borderRadius != borderRadius ||
        old.borderWidth != borderWidth ||
        old.gradient != gradient ||
        old.shape != shape ||
        old.filled != filled;
  }
}
