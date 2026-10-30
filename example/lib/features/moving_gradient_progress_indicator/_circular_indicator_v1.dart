part of 'moving_gradient_progress_indicator_screen.dart';

class _CircularIndicatorV1 extends StatelessWidget {
  final List<Color> colors;
  final double? progress;
  final EdgeInsets? thickness;

  const _CircularIndicatorV1({super.key, required this.colors, this.progress, this.thickness});

  @override
  Widget build(BuildContext context) {
    return CircularMovingGradientProgressIndicatorV1(
      progress: progress,
      thickness: thickness,
      colors: colors,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50,
        child: Text("Example"),
      ),
    );
  }
}
