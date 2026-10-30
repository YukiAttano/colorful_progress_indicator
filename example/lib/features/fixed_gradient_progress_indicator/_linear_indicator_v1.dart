part of 'fixed_gradient_progress_indicator_screen.dart';

class _LinearIndicatorV1 extends StatelessWidget {
  final List<Color> colors;
  final Color bgColor;
  final double? progress;
  final EdgeInsets? thickness;

  const _LinearIndicatorV1({super.key, required this.colors, required this.bgColor, this.progress, this.thickness});

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(14);

    return LinearFixedGradientProgressIndicatorV1(
      progress: progress,
      thickness: thickness,
      borderRadius: radius,
      childBorderRadius: radius,
      colors: colors,
      background: bgColor,
    );
  }
}
