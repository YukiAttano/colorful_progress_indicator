import 'package:example/routing/router.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  static const List<NavTarget> _targets = [
    NavTarget.FIXED,
    NavTarget.MOVING,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        _targets.length,
        (index) {
          NavTarget t = _targets[index];

          return _MenuEntry(target: t);
        },
      ),
    );
  }
}

class _MenuEntry extends StatelessWidget {
  final NavTarget target;

  const _MenuEntry({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _goto(context),
      child: Text(target.title),
    );
  }

  void _goto(BuildContext context) {
    target.navigate(context);
  }
}
