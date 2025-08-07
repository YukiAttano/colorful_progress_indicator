part of 'fixed_gradient_progress_indicator_screen.dart';

class _LinearIndicator extends StatelessWidget {
  final List<Color> colors;
  final Color bgColor;
  final double? progress;
  final EdgeInsets? thickness;

  const _LinearIndicator({super.key, required this.colors, required this.bgColor, this.progress, this.thickness});

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(14);

    return LinearFixedGradientProgressIndicator(
      progress: progress,
      thickness: thickness,
      borderRadius: radius,
      childBorderRadius: radius,
      colors: colors,
      background: bgColor,
    );
  }
}
