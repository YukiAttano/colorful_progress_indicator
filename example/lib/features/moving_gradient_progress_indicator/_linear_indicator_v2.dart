part of 'moving_gradient_progress_indicator_screen.dart';

class _LinearIndicatorV2 extends StatelessWidget {
  final List<Color> colors;

  final double? progress;
  final double? width;

  const _LinearIndicatorV2({super.key, required this.colors, this.progress, this.width});

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(14);

    return LinearMovingGradientProgressIndicator(
      progress: progress,
      width: width,
      borderRadius: radius,
      filled: true,
      colors: colors,
      child: SizedBox(
        height: width,
      ),
    );
  }
}
