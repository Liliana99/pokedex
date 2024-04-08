import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/pages/home_page.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_cubit.dart';

import 'package:flutter_application_1/app/modules/pokedex/pages/pokedex_page.dart';
import 'package:flutter_application_1/app/modules/pokemon_capture/widgets/pokeball_animation_capture.dart';
import 'package:flutter_application_1/app/modules/pokemon_capture/pages/pokeball_capture_page.dart';
import 'package:go_router/go_router.dart';

const String rootRoute = '/';
const String homeRoute = '/home';
const String pokedexRoute = '/pokedex';
const String pokemonCapturePage = '/pokemonCapturePage';
const String pokeballCapture = '/pokeballCapture';
const String pokeballCaptureList = '/pokeballCaptureList';
const String pokeballAnimationCapture = '/pokeballAnimationCapture';

GoRouter buildRoutes(PokedexCubit cubit) {
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
        pageBuilder: (BuildContext context, GoRouterState state) => fadeNav(
          state,
          const PokedexPage(),
        ),
      ),
      GoRoute(
        path: pokemonCapturePage,
        pageBuilder: (BuildContext context, GoRouterState state) => fadeNav(
          state,
          PokemonCapturePage(
            state: cubit.state,
            pokemonBackgroundColor: Colors.red,
          ),
        ),
      ),
      GoRoute(
        path: pokeballAnimationCapture,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            fadeNav(state, const PokeballAnimationCapture()),
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
