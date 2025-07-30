import "package:flutter/material.dart";

import "../consts.dart";

/// Base class for gradient progress indicators
abstract class GradientProgressIndicator extends StatefulWidget {
  final double? progress;
  final Duration duration;

  const GradientProgressIndicator({super.key, this.progress, Duration? duration})
    : duration = duration ?? const Duration(seconds: 2);

  @override
  State<GradientProgressIndicator> createState();
}

abstract class GradientProgressIndicatorState<T extends GradientProgressIndicator> extends State<T>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @protected
  AnimationController get controller => _controller!;

  @override
  void initState() {
    super.initState();

    initController();

    updateProgress(animate: false);
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      initController();
      updateProgress(animate: true);
    }
  }

  @protected
  @mustCallSuper
  void initController() {
    _controller?.stop();
    var old = _controller;
    var next = AnimationController(
      vsync: this,
      value: _controller?.value,
      upperBound: maxRadians,
      duration: widget.duration,
    );
    _controller = next;
    old?.dispose();
  }

  void updateProgress({required bool animate}) {
    double? progress = widget.progress;

    if (progress == null) {
      controller.repeat();
    } else {
      double animationValue = maxRadians * progress;

      if (animate) {
        controller.animateTo(animationValue);
      } else {
        controller.stop(canceled: false);
        controller.value = animationValue;
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
