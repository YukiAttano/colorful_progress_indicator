part of 'fixed_gradient_progress_indicator_screen.dart';

class _CircularIndicatorV2 extends StatelessWidget {
  final List<Color> colors;
  final Color bgColor;
  final double? progress;
  final double? width;

  const _CircularIndicatorV2({super.key, required this.colors, required this.bgColor, this.progress, this.width});

  @override
  Widget build(BuildContext context) {
    return CircularFixedGradientProgressIndicator(
      progress: progress,
      width: width,
      colors: colors,
      child: CircleAvatar(
        backgroundColor: bgColor,
        radius: 50,
        child: Text("Example"),
      ),
    );
  }
}
