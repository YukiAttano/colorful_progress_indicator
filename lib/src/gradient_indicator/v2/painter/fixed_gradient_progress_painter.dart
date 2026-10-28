import "dart:ui";

import "package:flutter/material.dart";

class FixedGradientProgressPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final double borderWidth;
  final Gradient gradient;
  final double progress;
  final bool fixed;

  FixedGradientProgressPainter({
    required this.borderRadius,
    required this.borderWidth,
    required this.gradient,
    required this.progress,
    required this.fixed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.0) return;

    Rect rect = Offset.zero & size;
    RRect rrect = borderRadius.toRRect(rect);

    Path fullPath = Path()..addRRectFromTopLeft(rrect);

    // compute path and only show half of it
    PathMetric metric = fullPath.computeMetrics().first;
    double totalLength = metric.length;
    double windowLength = totalLength / 2;

    double start = 0;
    if (!fixed) {
      // if 'fixed' is not set, the user progress bar is 'indefinite' and therefor never stops spinning.
      start = (progress * totalLength) % totalLength;
    } else {
      // if 'fixed' is set, the user manually controls the progress and therefor should see a progress bar that has an end.
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
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(extractedPath, paint);
  }

  @override
  bool shouldRepaint(covariant FixedGradientProgressPainter old) {
    return old.borderRadius != borderRadius ||
        old.borderWidth != borderWidth ||
        old.gradient != gradient ||
        old.progress != progress ||
        old.fixed != fixed;
  }
}

extension PathExtension on Path {
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
    lineTo(rrect.right, rrect.bottom - rrect.brRadius.y);
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
}
