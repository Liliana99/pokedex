import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app/home/pages/pokedex/blocs/pokedex_cubit.dart';
import 'package:flutter_application_1/app/router.dart';
import 'package:flutter_application_1/shared/repositories/pokemon_repository.dart/fetch_pokemon.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  final PokemonRepository pokemonRepository = PokemonRepository();

  final pokedexCubit = PokedexCubit(pokemonRepository);

  runApp(
    RepositoryProvider(
      create: (context) => PokemonRepository(),
      child: BlocProvider(
        create: (_) => pokedexCubit,
        child: DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => const MyApp(), // Wrap your app
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter router;

  @override
  void initState() {
    router = buildRoutes();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Pokédex',
      theme: buildThemeData(),
    );
  }
}
