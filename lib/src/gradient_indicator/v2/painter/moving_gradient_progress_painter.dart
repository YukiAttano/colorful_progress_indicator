import "package:flutter/rendering.dart";

class MovingGradientProgressPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final double borderWidth;
  final Gradient gradient;
  final BoxShape shape;
  final bool filled;

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

  late void Function(Path path, Rect rect) _drawShape;

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;

    Path path = Path();
    _drawShape(path, rect);

    // if (!filled) {
    //   RRect innerRRect = outerRRect.deflate(borderWidth);
    //   path
    //     ..addRRect(innerRRect)
    //     ..fillType = PathFillType.evenOdd;
    // }

    Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round;

    paint.style = filled ? PaintingStyle.fill : PaintingStyle.stroke;

    canvas.drawPath(path, paint);
  }

  void _addRRect(Path path, Rect rect) {
    RRect outerRRect = borderRadius.toRRect(rect);

    path.addRRect(outerRRect);
  }

  void _addCircle(Path path, Rect rect) {
    path.addOval(rect);
  }

  @override
  bool shouldRepaint(covariant MovingGradientProgressPainter old) {
    return old.borderRadius != borderRadius || old.borderWidth != borderWidth || old.gradient != gradient;
  }
}
