import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokedex_profile_complete_modal.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokemon_detail_info.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokemon_header_info.dart';
import 'package:flutter_application_1/app/router.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_application_1/shared/widgets/app_bar.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_application_1/utils/obtain_pokemon_color.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';

import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_state.dart';

class PokemonCapturedList extends StatefulWidget {
  final Color? pokemonBackgroundColor;
  final PokedexState state;
  const PokemonCapturedList({
    super.key,
    this.pokemonBackgroundColor,
    required this.state,
  });

  @override
  State<PokemonCapturedList> createState() => _PokemonCapturedListState();
}

class _PokemonCapturedListState extends State<PokemonCapturedList> {
  final AppinioSwiperController controller = AppinioSwiperController();

  @override
  void initState() {
    if (widget.state.capturedPokemons != null) {
      Future.delayed(const Duration(seconds: 1)).then((_) {
        _shakeCard();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state.capturedPokemons == null) {
      return Scaffold(
        appBar: AppAppBar(
          foregroundColor: Colors.red,
          leading: IconButton(
              onPressed: () => context.go(homeRoute),
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "No existen pokemons capturados...",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: context.headM!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => context.go(homeRoute),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .75,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 50,
                bottom: 40,
              ),
              child: AppinioSwiper(
                invertAngleOnBottomDrag: true,
                backgroundCardCount: 3,
                swipeOptions: const SwipeOptions.all(),
                controller: controller,
                onCardPositionChanged: (
                  SwiperPosition position,
                ) {},
                onSwipeEnd: _swipeEnd,
                onEnd: _onEnd,
                cardCount: widget.state.capturedPokemons!.length,
                cardBuilder: (BuildContext context, int index) {
                  PokemonModel pokemon = widget.state.capturedPokemons![index]!;
                  Color pokemonBackgroundColor =
                      findPokemonTypeColor(pokemon.types!.first.type!.name!);

                  return widget.state.capturedPokemons!
                              .indexOf(widget.state.capturedPokemons![index]) ==
                          widget.state.capturedPokemons!.length - 1
                      ? PokemonCapturedCardEmpty(
                          backgroundColor: widget.pokemonBackgroundColor,
                        )
                      : PokemonCapturedCard(
                          backgroundColor: pokemonBackgroundColor,
                          pokemon: pokemon,
                          state: widget.state,
                          onTap: () async {
                            showPokemonModal(
                                context: context,
                                backgroundColor: pokemonBackgroundColor,
                                pokemon: widget.state.capturedPokemons![index]!,
                                state: widget.state);
                          });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _swipeEnd(int previousIndex, int targetIndex, SwiperActivity activity) {
    var log = Logger();
    switch (activity) {
      case Swipe():
        log.d('The card was swiped to the : ${activity.direction}');
        log.d(
            'Swipe : previous index: $previousIndex, target index: $targetIndex');

        break;
      case Unswipe():
        log.d('A ${activity.direction.name} swipe was undone.');
        log.d('previous index: $previousIndex, target index: $targetIndex');

        break;
      case CancelSwipe():
        log.d('A swipe was cancelled');
        break;
      case DrivenActivity():
        log.d('Driven Activity');
        break;
    }
  }

  void _onEnd() {
    var log = Logger();
    log.d('end reached!');
  }

  Future<void> _shakeCard() async {
    const double distance = 30;
    // We can animate back and forth by chaining different animations.
    await controller.animateTo(
      const Offset(-distance, 0),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    await controller.animateTo(
      const Offset(distance, 0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    // We need to animate back to the center because `animateTo` does not center
    // the card for us.
    await controller.animateTo(
      const Offset(0, 0),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}

class PokemonCapturedCardEmpty extends StatelessWidget {
  final Color? backgroundColor;
  const PokemonCapturedCardEmpty({super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: backgroundColor!,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            "Fin de la lista...",
            maxLines: 3,
            textAlign: TextAlign.center,
            style: context.headM!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class PokemonCapturedCard extends StatelessWidget {
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final PokemonModel pokemon;
  final PokedexState state;
  const PokemonCapturedCard({
    super.key,
    this.backgroundColor,
    this.onTap,
    required this.pokemon,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    String? specieDescription;
    PokemonSpecieModel? pokemonSpecieModel;

    if (state.pokemonSpecie != null && state.pokemonSpecie!.isNotEmpty) {
      pokemonSpecieModel = state.pokemonSpecie!
          .firstWhere((pokemonSpecie) => pokemonSpecie.id == pokemon.id);
      specieDescription = pokemonSpecieModel.getFlavorTextInSpanish()!;
    }

    return Card.filled(
      color: backgroundColor!,
      child: InkWell(
        onTap: onTap,
        child: Column(children: <Widget>[
          Flexible(
            child: Stack(
              children: [
                PokemonHeaderInfo(
                    backgroundColor: backgroundColor!, pokemon: pokemon),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Transform.scale(
                        scale: 0.9,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Transform.translate(
                            offset: const Offset(0.0, 1.25),
                            child: Center(
                              child: Image.network(
                                  pokemon.sprites!.other!.home!.frontDefault!,
                                  cacheWidth: 300,
                                  cacheHeight: 300,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Flexible(
            child: PokemonDetailInfo(
              pokemon: pokemon,
              pokemonSpecieModel: pokemonSpecieModel,
              specieDescription: specieDescription,
            ),
          ),
          const SizedBox(height: 10),
        ]),
      ),
    );
  }
}
