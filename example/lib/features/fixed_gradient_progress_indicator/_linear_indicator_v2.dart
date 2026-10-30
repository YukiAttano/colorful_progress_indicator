part of 'fixed_gradient_progress_indicator_screen.dart';

class _LinearIndicatorV2 extends StatelessWidget {
  final List<Color> colors;

  final double? progress;
  final double? width;

  const _LinearIndicatorV2({super.key, required this.colors, this.progress, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox();

    // return LinearFixedGradientProgressIndicator(
    //   progress: progress,
    //   width: width,
    //   colors: colors,
    // );
  }
}
