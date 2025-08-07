import "package:flutter/material.dart";

class TitledSlider extends StatelessWidget {
  final Widget title;
  final bool checked;
  final double value;
  final void Function(bool checked)? onCheckedChanged;
  final void Function(double value) onValueChanged;

  const TitledSlider({
    super.key,
    required this.title,
    this.checked = true,
    required this.value,
    required this.onValueChanged,
    this.onCheckedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        Row(
          children: [
            Visibility(
              visible: onCheckedChanged != null,
              child: Checkbox(
                value: checked,
                onChanged: (value) => _onCheckedChanged(value ?? false),
              ),
            ),
            Expanded(
              child: Slider(value: value, onChanged: _onValueChanged),
            ),
          ],
        )
      ],
    );
  }

  void _onCheckedChanged(bool checked) {
    onCheckedChanged?.call(checked);
  }

  void _onValueChanged(double value) {
    if (!checked) _onCheckedChanged(true);
    onValueChanged(value);
  }
}
