import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/home/pages/home/pages/home_page.dart';
import 'package:flutter_application_1/app/home/pages/pokedex/pages/pokedex_page.dart';
import 'package:go_router/go_router.dart';

const String rootRoute = '/';
const String homeRoute = '/home';
const String pokedexRoute = '/pokedex';

GoRouter buildRoutes() {
  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: rootRoute,
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
      ),
      GoRoute(
        path: homeRoute,
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
      ),
      GoRoute(
        path: pokedexRoute,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            fadeNav(state, const PokedexPage()),
      ),
    ],
  );
}

CustomTransitionPage<void> fadeNav(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: ValueKey(state.path),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
