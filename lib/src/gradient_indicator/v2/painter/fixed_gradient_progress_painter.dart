import "dart:math" as math;
import "dart:ui";

import "package:flutter/material.dart";

import "../../../../colorful_progress_spinner.dart";

class FixedGradientProgressPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final double borderWidth;
  final Gradient gradient;
  final BoxShape shape;
  final double progress;

  /// The relative length of the border when [indeterminate] is true
  final double relativeLength;

  /// If [indeterminate] is true, progress keeps repeating
  final bool indeterminate;

  late void Function(Path path, Rect rect) _drawShape;

  FixedGradientProgressPainter({
    required this.borderRadius,
    required this.borderWidth,
    required this.gradient,
    required this.shape,
    required this.progress,
    required this.relativeLength,
    required this.indeterminate,
  }) : assert(relativeLength >= 0 && relativeLength <= 1, "relativeLength must be between 0 and 1") {
    switch (shape) {
      case BoxShape.rectangle:
        _drawShape = _addRRect;
      case BoxShape.circle:
        _drawShape = _addCircle;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.0) return;
    if (size == Size.zero) return;

    Rect rect = Offset.zero & size;

    Path fullPath = Path();
    
    _drawShape(fullPath, rect);

    // compute path and only show half of it
    PathMetric? metric = fullPath.computeMetrics().first;
    double totalLength = metric.length;
    double windowLength = totalLength * relativeLength;

    double start = 0;
    if (indeterminate) {
      // if 'indeterminate' is true, the progress bar never stops spinning.
      start = (progress * totalLength) % totalLength;
    } else {
      // if 'indeterminate' is false, the user manually controls the progress and therefor should see a progress bar that has an end.
      windowLength = totalLength * progress;
    }

    double end = start + windowLength;

    Path extractedPath = Path();

    // check whether end must not be wrapped-around (reaches not into the start again)
    if (end <= totalLength) {
      extractedPath = metric.extractPath(start, end);
    } else {
      // if it overlaps, add the start of the path
      extractedPath.addPath(metric.extractPath(start, totalLength), Offset.zero);
      // and the end (which is wrapped around here)
      extractedPath.addPath(metric.extractPath(0, end - totalLength), Offset.zero);
    }

    Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(extractedPath, paint);
  }
  
  void _addRRect(Path path, Rect rect) {
    RRect rrect = borderRadius.toRRect(rect);

    path.addRRectFromTopLeftCenter(rrect);
  }

  void _addCircle(Path path, Rect rect) {
    path.addArc(rect, topCenter, fullCircle);
  }

  @override
  bool shouldRepaint(covariant FixedGradientProgressPainter old) {
    return old.borderRadius != borderRadius ||
        old.borderWidth != borderWidth ||
        old.gradient != gradient ||
        old.progress != progress ||
        old.relativeLength != relativeLength ||
        old.indeterminate != indeterminate;
  }
}

extension PathExtension on Path {
  static final double _halfSqrt = math.sqrt(0.5);

  /// Flutter default [Path.addRRect] starts their path at the bottom left, after the arc.
  ///
  /// This method starts at the top left, before the arc.
  void addRRectFromTopLeft(RRect rrect) {
    moveTo(
      rrect.left,
      rrect.top + rrect.tlRadius.y,
    );
    arcToPoint(
      Offset(rrect.left + rrect.tlRadius.x, rrect.top),
      radius: rrect.tlRadius,
    );
    lineTo(
      rrect.right - rrect.trRadius.x,
      rrect.top,
    );
    arcToPoint(
      Offset(rrect.right, rrect.top + rrect.trRadius.y),
      radius: rrect.trRadius,
    );
    lineTo(
      rrect.right,
      rrect.bottom - rrect.brRadius.y,
    );
    arcToPoint(
      Offset(rrect.right - rrect.brRadius.x, rrect.bottom),
      radius: rrect.brRadius,
    );
    lineTo(
      rrect.left + rrect.blRadius.x,
      rrect.bottom,
    );
    arcToPoint(
      Offset(rrect.left, rrect.bottom - rrect.blRadius.y),
      radius: rrect.blRadius,
    );
    lineTo(
      rrect.left,
      rrect.top + rrect.tlRadius.y,
    );
    close();
  }

  /// This method starts at the top left, in the mid of the arc.
  void addRRectFromTopLeftCenter(RRect rrect) {
    double rx = rrect.tlRadius.x;
    double ry = rrect.tlRadius.y;
    double cx = rrect.left + rx;
    double cy = rrect.top + ry;

    // Midpoint of the top-left arc
    double midX = cx - rx * _halfSqrt;
    double midY = cy - ry * _halfSqrt;

    // Start at the center (midpoint) of the top-left arc
    moveTo(midX, midY);

    // Complete the first half of the top-left arc
    arcToPoint(
      Offset(rrect.left + rx, rrect.top),
      radius: rrect.tlRadius,
    );
    lineTo(
      rrect.right - rrect.trRadius.x,
      rrect.top,
    );
    arcToPoint(
      Offset(rrect.right, rrect.top + rrect.trRadius.y),
      radius: rrect.trRadius,
    );
    lineTo(
      rrect.right,
      rrect.bottom - rrect.brRadius.y,
    );
    arcToPoint(
      Offset(rrect.right - rrect.brRadius.x, rrect.bottom),
      radius: rrect.brRadius,
    );
    lineTo(
      rrect.left + rrect.blRadius.x,
      rrect.bottom,
    );
    arcToPoint(
      Offset(rrect.left, rrect.bottom - rrect.blRadius.y),
      radius: rrect.blRadius,
    );
    lineTo(
      rrect.left,
      rrect.top + ry,
    );

    // Complete the second half of the top-left arc back to the starting point
    arcToPoint(
      Offset(midX, midY),
      radius: rrect.tlRadius,
    );
    close();
  }
}
