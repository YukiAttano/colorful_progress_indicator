import 'package:example/features/fixed_gradient_progress_indicator/fixed_gradient_progress_indicator_screen.dart';
import 'package:example/routing/widgets/menu_screen.dart';
import 'package:example/routing/widgets/nav_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/moving_gradient_progress_indicator/moving_gradient_progress_indicator_screen.dart';

NavTarget initTarget = NavTarget.MENU;

final router = Provider((ref) {
  return GoRouter(
    initialLocation: initTarget.route,
    redirect: (context, state) {
      if (state.uri.toString().isEmpty || state.uri.toString() == "/") {
        return initTarget.route;
      }
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return NavShell(state: state, child: child);
        },
        routes: [
          GoRoute(
            path: NavTarget.MENU.route,
            builder: (context, state) {
              return const MenuScreen();
            },
          ),
          GoRoute(
            path: NavTarget.FIXED.route,
            builder: (context, state) {
              return const FixedGradientProgressIndicatorScreen();
            },
          ),
          GoRoute(
            path: NavTarget.MOVING.route,
            builder: (context, state) {
              return const MovingGradientProgressIndicatorScreen();
            },
          ),
        ],
      ),
    ],
  );
});

enum NavTarget {
  MENU("/menu", "Menu", ""),
  FIXED("/fixed", "FixedGradientProgressIndicator", "Changing the duration and the gradient is also possible"),
  MOVING("/moving", "MovingGradientProgressIndicator", "Changing the duration and the gradient is also possible"),
  ;

  const NavTarget(this.route, this.title, this.description);

  final String route;
  final String title;
  final String description;

  static NavTarget fromRoute(String route) {
    for (var r in values) {
      if (r.route == route) {
        return r;
      }
    }

    return MENU;
  }

  Future<void> navigate(BuildContext context) {
    return GoRouter.of(context).push(route);
  }
}
