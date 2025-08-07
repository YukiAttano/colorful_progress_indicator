import 'package:colorful_progress_spinner/colorful_progress_indicator.dart';
import 'package:example/shared/widgets/screen.dart';
import 'package:example/shared/widgets/titled_slider.dart';
import 'package:flutter/material.dart';

part '_box_indicator.dart';

part '_linear_indicator.dart';

part '_circular_indicator.dart';

class FixedGradientProgressIndicatorScreen extends StatefulWidget {
  const FixedGradientProgressIndicatorScreen({super.key});

  @override
  State<FixedGradientProgressIndicatorScreen> createState() => _FixedGradientProgressIndicatorScreenState();
}

class _FixedGradientProgressIndicatorScreenState extends State<FixedGradientProgressIndicatorScreen> {
  double _thickness = 0.4;

  EdgeInsets get thickness => EdgeInsets.all(_thickness * 10);
  double _progress = 0;
  bool _indefinite = true;

  double _bgTransparency = 1;

  final List<Color> _colors = [
    GradientColors.razerChroma.last,
    ...GradientColors.razerChroma,
  ];

  @override
  Widget build(BuildContext context) {
    Color bgColor = Theme.of(context).canvasColor.withValues(alpha: _bgTransparency);
    var progress = _indefinite ? null : _progress;

    return Screen(
      title: "",
      description: "The colors stay in place and made visible during the animation",
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
                      bgColor: bgColor,
                    ),
                    const SizedBox(height: 20),
                    _LinearIndicator(
                      thickness: thickness / 2,
                      progress: progress,
                      colors: _colors,
                      bgColor: bgColor,
                    ),
                    const SizedBox(height: 20),
                    _CircularIndicator(
                      thickness: thickness,
                      progress: progress,
                      colors: _colors,
                      bgColor: bgColor,
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
                bgTransparency: _bgTransparency,
                onBgTransparencyChanged: _onBgTransparencyChanged,
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

  void _onBgTransparencyChanged(double value) {
    setState(() => _bgTransparency = value);
  }
}

class _Controls extends StatelessWidget {
  final double progress;
  final bool indefinite;
  final void Function(double progress) onProgressChanged;
  final void Function(bool indefinite) onCheckedChanged;

  final double thickness;
  final void Function(double progress) onThicknessChanged;

  final double bgTransparency;
  final void Function(double progress) onBgTransparencyChanged;

  const _Controls({
    super.key,
    required this.progress,
    required this.indefinite,
    required this.onProgressChanged,
    required this.onCheckedChanged,
    required this.thickness,
    required this.onThicknessChanged,
    required this.bgTransparency,
    required this.onBgTransparencyChanged,
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
        TitledSlider(
          title: Text("Background Transparency"),
          value: bgTransparency,
          onValueChanged: onBgTransparencyChanged,
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
