part of 'moving_gradient_progress_indicator_screen.dart';

class _CircularIndicatorV2 extends StatelessWidget {
  final List<Color> colors;
  final double? progress;
  final double? width;

  const _CircularIndicatorV2({super.key, required this.colors, this.progress, this.width});

  @override
  Widget build(BuildContext context) {
    return CircularMovingGradientProgressIndicator(
      progress: progress,
      width: width,
      colors: colors,
      child: CircleAvatar(
        backgroundColor: ColorScheme.of(context).surface,
        radius: 50,
        child: Text("Example"),
      ),
    );
  }
}
