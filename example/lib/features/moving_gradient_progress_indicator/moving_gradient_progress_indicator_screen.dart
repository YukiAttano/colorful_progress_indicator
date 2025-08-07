import 'package:colorful_progress_spinner/colorful_progress_indicator.dart';
import 'package:example/shared/widgets/screen.dart';
import 'package:example/shared/widgets/titled_slider.dart';
import 'package:flutter/material.dart';

part '_box_indicator.dart';

part '_linear_indicator.dart';

part '_circular_indicator.dart';

class MovingGradientProgressIndicatorScreen extends StatefulWidget {
  const MovingGradientProgressIndicatorScreen({super.key});

  @override
  State<MovingGradientProgressIndicatorScreen> createState() => _MovingGradientProgressIndicatorScreenState();
}

class _MovingGradientProgressIndicatorScreenState extends State<MovingGradientProgressIndicatorScreen> {
  double _thickness = 0.4;

  EdgeInsets get thickness => EdgeInsets.all(_thickness * 10);
  double _progress = 0;
  bool _indefinite = true;


  final List<Color> _colors = [
    GradientColors.razerChroma.last,
    ...GradientColors.razerChroma,
  ];

  @override
  Widget build(BuildContext context) {
    var progress = _indefinite ? null : _progress;

    return Screen(
      title: "",
      description: "The colors move around the child widget",
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _BoxIndicator(
                      thickness: thickness,
                      progress: progress,
                      colors: _colors,

                    ),
                    const SizedBox(height: 20),
                    _LinearIndicator(
                      thickness: thickness / 2,
                      progress: progress,
                      colors: _colors,

                    ),
                    const SizedBox(height: 20),
                    _CircularIndicator(
                      thickness: thickness,
                      progress: progress,
                      colors: _colors,

                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _Controls(
                progress: _progress,
                onProgressChanged: _onProgressChanged,
                indefinite: _indefinite,
                onCheckedChanged: _onIndefiniteChanged,
                thickness: _thickness,
                onThicknessChanged: _onThicknessChanged,

              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onIndefiniteChanged(bool value) {
    setState(() => _indefinite = value);
  }

  void _onProgressChanged(double value) {
    setState(() => _progress = value);
  }

  void _onThicknessChanged(double value) {
    setState(() => _thickness = value);
  }

}

class _Controls extends StatelessWidget {
  final double progress;
  final bool indefinite;
  final void Function(double progress) onProgressChanged;
  final void Function(bool indefinite) onCheckedChanged;

  final double thickness;
  final void Function(double progress) onThicknessChanged;


  const _Controls({
    super.key,
    required this.progress,
    required this.indefinite,
    required this.onProgressChanged,
    required this.onCheckedChanged,
    required this.thickness,
    required this.onThicknessChanged,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TitledSlider(
          title: Text("Progress"),
          value: progress,
          checked: !indefinite,
          onCheckedChanged: _onCheckedChanged,
          onValueChanged: _onProgressChanged,
        ),
        TitledSlider(
          title: Text("Thickness"),
          value: thickness,
          onValueChanged: onThicknessChanged,
        ),

      ],
    );
  }

  void _onCheckedChanged(bool checked) {
    onCheckedChanged(!checked);
  }

  void _onProgressChanged(double value) {
    onProgressChanged(value);
  }
}
