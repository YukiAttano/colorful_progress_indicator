part of 'moving_gradient_progress_indicator_screen.dart';

class _LinearIndicatorV1 extends StatelessWidget {
  final List<Color> colors;

  final double? progress;
  final EdgeInsets? thickness;

  const _LinearIndicatorV1({super.key, required this.colors, this.progress, this.thickness});

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(14);

    return LinearMovingGradientProgressIndicatorV1(
      progress: progress,
      thickness: thickness,
      borderRadius: radius,
      childBorderRadius: radius,
      colors: colors,
      filled: true,
      child: SizedBox(
        height: thickness?.horizontal ?? 5,
      ),
    );
  }
}
