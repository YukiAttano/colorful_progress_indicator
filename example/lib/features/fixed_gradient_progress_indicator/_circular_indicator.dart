part of 'fixed_gradient_progress_indicator_screen.dart';

class _CircularIndicator extends StatelessWidget {
  final List<Color> colors;
  final Color bgColor;
  final double? progress;
  final EdgeInsets? thickness;

  const _CircularIndicator({super.key, required this.colors, required this.bgColor, this.progress, this.thickness});

  @override
  Widget build(BuildContext context) {
    return CircularFixedGradientProgressIndicator(
      progress: progress,
      thickness: thickness,
      colors: colors,
      background: bgColor,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50,
        child: Text("Example"),
      ),
    );
  }
}
