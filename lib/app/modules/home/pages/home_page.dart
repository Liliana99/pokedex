import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/widgets/pokeball_widget.dart';
import 'package:flutter_application_1/app/modules/home/widgets/section_card.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_cubit.dart';
import 'package:flutter_application_1/app/router.dart';
import 'package:flutter_application_1/shared/repositories/pokemon_repository.dart/fetch_pokemon.dart';
import 'package:flutter_application_1/utils/calculate_dimensions.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PokemonRepository pokemonRepository = PokemonRepository();

    return BlocProvider(
      create: (context) => PokedexCubit(pokemonRepository),
      child: const HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final dimensions = calculateDimensions(context, size);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          const Spacer(),
          Expanded(
            child: TitleAndPokeball(
              maxWidthLogo: dimensions.maxWidthLogo,
            ),
          ),
          Expanded(
            child: ActionButtons(
              maxWidth: dimensions.maxWidth,
              maxHeight: dimensions.maxHeight,
              onPressedButton1: () => context.go(pokedexRoute),
              onPressedButton2: () => context.go(
                pokemonCapturePage,
              ),
            ),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}

class TitleAndPokeball extends StatelessWidget {
  final double maxWidthLogo;

  const TitleAndPokeball({super.key, required this.maxWidthLogo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Pokédex',
          style: context.dispM!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        Expanded(
          flex: 4,
          child: PokeballImage(
            maxWidthLogo: maxWidthLogo,
            color: Colors.yellow.shade600.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final VoidCallback onPressedButton1;
  final VoidCallback onPressedButton2;

  const ActionButtons(
      {super.key,
      required this.maxWidth,
      required this.maxHeight,
      required this.onPressedButton1,
      required this.onPressedButton2});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FeatureCardWithEmoji(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            title: 'Pokédex',
            isLightColor: true,
            color: Colors.yellow.shade600,
            emoji: '❖',
            onPressed: onPressedButton1,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: FeatureCardWithEmoji(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            title: 'Capturados',
            isLightColor: false,
            color: const Color(0xff3b4cca),
            emoji: '🧿',
            onPressed: onPressedButton2,
          ),
        ),
      ],
    );
  }
}

class FeatureCardWithEmoji extends StatelessWidget {
  const FeatureCardWithEmoji({
    super.key,
    required this.maxWidth,
    required this.maxHeight,
    required this.title,
    required this.isLightColor,
    required this.color,
    required this.emoji,
    required this.onPressed,
  });

  final double maxWidth;
  final double maxHeight;
  final String title;
  final bool? isLightColor;
  final Color color;
  final String emoji;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
            child: SectionCard(
              title: title,
              color: color,
              isLightColor: isLightColor!,
              onPressed: onPressed,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            emoji,
            style: const TextStyle(
              fontSize: 25,
              fontFamily: 'NotoEmoji',
            ),
          ),
        ),
      ],
    );
  }
}
