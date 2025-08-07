part of 'moving_gradient_progress_indicator_screen.dart';

class _CircularIndicator extends StatelessWidget {
  final List<Color> colors;
  final double? progress;
  final EdgeInsets? thickness;

  const _CircularIndicator({super.key, required this.colors, this.progress, this.thickness});

  @override
  Widget build(BuildContext context) {
    return CircularMovingGradientProgressIndicator(
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
