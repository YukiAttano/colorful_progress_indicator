import "dart:ui";

import "package:flutter/material.dart";

import "../../../../colorful_progress_spinner.dart";
import "../../gradient_progress_indicator.dart";

/// A progress indicator that shows the same color on the same position while animating.
///
/// Works by drawing a Gradient in the background and partially revealing it with applying a foreground gradient on it.
class FixedGradientProgressIndicator extends GradientProgressIndicator {
  final Widget? child;

  /// animationValue will be between 0 and [maxRadians]
  final Gradient Function(double animationValue) fgGradient;

  final double width;

  final BorderRadius borderRadius;

  final bool filled;
  final bool fixed;

  const FixedGradientProgressIndicator.custom({
    super.key,
    this.child,
    required this.fgGradient,
    super.enabled,
    super.progress,
    double? width,
    BorderRadius? borderRadius,
    bool? filled,
    super.duration,
  }) : width = width ?? 1,
       borderRadius = borderRadius ?? BorderRadius.zero,
       filled = filled ?? false,
       fixed = progress != null;

  FixedGradientProgressIndicator({
    Key? key,
    required Widget child,
    required List<Color> colors,
    bool? enabled,
    double? progress,
    double? width,
    BorderRadius? borderRadius,
    bool? filled,
    Duration? duration,
  }) : this.custom(
         key: key,
         child: child,
         fgGradient: (animationValue) => defaultProgressFgGradient(colors, animationValue),
         enabled: enabled,
         progress: progress,
         width: width,
         borderRadius: borderRadius,
         filled: filled,
         duration: duration,
       );

  static Gradient defaultProgressFgGradient(List<Color> colors, double animationValue) {
    return SweepGradient(
      tileMode: animationValue == maxRadians ? TileMode.repeated : TileMode.clamp,
      transform: const GradientRotation(topCenter),
      colors: colors,
    );
  }

  @override
  State<FixedGradientProgressIndicator> createState() => _FixedGradientProgressIndicatorState();
}

class _FixedGradientProgressIndicatorState extends GradientProgressIndicatorState<FixedGradientProgressIndicator> {
  late Gradient _gradient;

  @override
  void initState() {
    super.initState();

    _updateGradient();
  }

  @override
  void initController() {
    super.initController();

    controller.addListener(() {
      setState(_updateGradient);
    });
  }

  @override
  void didUpdateWidget(covariant FixedGradientProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.progress != widget.progress) {
      updateProgress(animate: oldWidget.progress != null && widget.progress != null);
    } else if (oldWidget.fgGradient != widget.fgGradient) {
      _updateGradient();
    }
  }

  void _updateGradient() {
    _gradient = widget.fgGradient(controller.value);
  }

  @override
  Widget build(BuildContext context) {
    Gradient? fgGradient = _gradient;

    _GradientProgressBorderPainter? painter;

    if (widget.enabled) {
      painter = _GradientProgressBorderPainter(
        progress: controller.value / maxRadians,
        gradient: fgGradient,
        borderWidth: widget.width,
        borderRadius: widget.borderRadius,
        fixed: widget.fixed,
      );
    }

    return CustomPaint(painter: painter, child: widget.child);
  }
}

class _GradientProgressBorderPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final double borderWidth;
  final Gradient gradient;
  final double progress;
  final bool fixed;

  _GradientProgressBorderPainter({
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
  bool shouldRepaint(covariant _GradientProgressBorderPainter old) {
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
