part of 'moving_gradient_progress_indicator_screen.dart';

class _LinearIndicator extends StatelessWidget {
  final List<Color> colors;

  final double? progress;
  final EdgeInsets? thickness;

  const _LinearIndicator({super.key, required this.colors, this.progress, this.thickness});

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(14);

    return LinearMovingGradientProgressIndicator(
      progress: progress,
      thickness: thickness,
      borderRadius: radius,
      childBorderRadius: radius,
      colors: colors,
    );
  }
}
