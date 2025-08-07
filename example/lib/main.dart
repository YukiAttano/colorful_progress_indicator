import 'package:example/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: ColorfulProgressIndicatorExample()));
}

class ColorfulProgressIndicatorExample extends ConsumerWidget {
  const ColorfulProgressIndicatorExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Colorful Progress Indicator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: ref.watch(router),
    );
  }
}
