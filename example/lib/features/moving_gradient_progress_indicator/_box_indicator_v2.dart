part of 'moving_gradient_progress_indicator_screen.dart';

class _BoxIndicatorV2 extends StatelessWidget {
  final List<Color> colors;

  final double? progress;
  final double? width;

  const _BoxIndicatorV2({super.key, required this.colors, this.progress, this.width});

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(14);

    return MovingGradientProgressIndicator(
      progress: progress,
      width: width,
      borderRadius: radius,
      colors: colors,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: radius),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("This is the child of the loading\nindicator that gets surrounded by it."),
              Visibility.maintain(visible: false, child: Text("Best results will be achieved with square boxes")),
            ],
          ),
        ),
      ),
    );
  }
}
