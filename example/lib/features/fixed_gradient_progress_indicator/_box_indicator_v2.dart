part of 'fixed_gradient_progress_indicator_screen.dart';

class _BoxIndicatorV2 extends StatelessWidget {
  final List<Color> colors;
  final double? progress;
  final double? width;
  final Color? bgColor;

  const _BoxIndicatorV2({super.key, required this.colors, this.progress, this.width, this.bgColor});

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(14);

    return FixedGradientProgressIndicator(
      progress: progress,
      width: width,
      borderRadius: radius,
      colors: colors,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: radius),
        margin: EdgeInsets.zero,
        color: bgColor,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("This is the child of the loading\nindicator that gets surrounded by it."),
              Text("Best results will be achieved with square boxes"),
            ],
          ),
        ),
      ),
    );
  }
}
