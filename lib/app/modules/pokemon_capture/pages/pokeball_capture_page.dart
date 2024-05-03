import 'dart:math';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_cubit.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokedex_profile_complete_modal.dart';
import 'package:flutter_application_1/app/modules/pokemon_capture/widgets/pokemon_card.dart';
import 'package:flutter_application_1/app/router.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_application_1/shared/widgets/app_bar.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_application_1/utils/obtain_pokemon_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_state.dart';

class PokemonCapturePage extends StatelessWidget {
  const PokemonCapturePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const PokemonCaptureContent();
  }
}

class PokemonCaptureContent extends StatefulWidget {
  final Color? pokemonBackgroundColor;
  final PokedexState? pokemonState;

  const PokemonCaptureContent({
    super.key,
    this.pokemonBackgroundColor,
    this.pokemonState,
  });

  @override
  State<PokemonCaptureContent> createState() => _PokemonCaptureContentState();
}

class _PokemonCaptureContentState extends State<PokemonCaptureContent> {
  final AppinioSwiperController controller = AppinioSwiperController();
  bool isFinalList = false;

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
    ).then((_) {
      _shakeCard();
    });

    super.initState();
  }

  void determinePositionList(int currentIndex) {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokedexCubit, PokedexState>(
      builder: (context, _) {
        PokedexState state = widget.pokemonState!;

        if (state.capturedPokemons == null ||
            state.capturedPokemons!.isEmpty ||
            isFinalList) {
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
                        isFinalList
                            ? "Fin de Lista...."
                            : "No existen pokemons capturados...",
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
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.white),
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
                    onSwipeEnd: (int, index, SwiperActivity) {
                      if (int == state.capturedPokemons!.length - 1) {
                        setState(() {
                          isFinalList = true;
                        });
                      }
                    },
                    onEnd: () {},
                    cardCount: state.capturedPokemons!.length,
                    cardBuilder: (BuildContext context, int index) {
                      PokemonModel pokemon = state.capturedPokemons![index]!;

                      Color pokemonBackgroundColor = pokemon.types != null
                          ? findPokemonTypeColor(
                                  pokemon.types!.first.type!.name!) ??
                              Colors.red
                          : Colors.red;

                      return state.capturedPokemons!.indexOf(
                                      state.capturedPokemons![index]) ==
                                  state.capturedPokemons!.length - 1 &&
                              state.capturedPokemons!.isEmpty
                          ? PokemonCapturedCardEmpty(
                              backgroundColor: widget.pokemonBackgroundColor,
                            )
                          : DynamicPokemonCardWidget(
                              currentIndex: index,
                              backgroundColor: pokemonBackgroundColor,
                              pokemon: pokemon,
                              state: state,
                              onTap: () async {
                                showPokemonModal(
                                    context: context,
                                    backgroundColor: pokemonBackgroundColor,
                                    pokemon: state.capturedPokemons![index]!,
                                    state: state);
                              });
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _shakeCard() async {
    const double distance = 30;
    // We can animate back and forth by chaining different animations.
    await controller.animateTo(
      const Offset(-distance, 0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    await controller.animateTo(
      const Offset(distance, 0),
      duration: const Duration(milliseconds: 600),
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

class DynamicPokemonCardWidget extends StatelessWidget {
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final PokemonModel pokemon;
  final PokedexState state;
  final int currentIndex;
  const DynamicPokemonCardWidget({
    super.key,
    this.backgroundColor,
    this.onTap,
    required this.pokemon,
    required this.state,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    PokemonSpecieModel? pokemonSpecieModel;
    const double oneCeroAngle = -pi * 0.1;
    double defaultAngle = pi * -0;
    Offset getOffSer(int index) {
      return {
            0: const Offset(0, 30),
            1: const Offset(-5, 30),
            2: const Offset(5, 30),
          }[index] ??
          const Offset(0, 0);
    }

    double getAngle(int index) {
      switch (index % 3) {
        case 0:
          return oneCeroAngle;
        case 1:
          return -oneCeroAngle;
        case 2:
          return defaultAngle;
        default:
          return oneCeroAngle;
      }
    }

    double getScale(int index) {
      switch (index % 3) {
        case 0:
          return 0.7;
        case 1:
          return 0.9;
        case 2:
          return 0.95;
        default:
          return 0.7;
      }
    }

    return Transform.translate(
      offset: getOffSer(currentIndex),
      child: Transform.scale(
        scale: getScale(currentIndex),
        child: Transform.rotate(
          angle: getAngle(currentIndex),
          child: PokemonCardCaptured(
            pokemon: pokemon,
            state: state,
            onTap: onTap,
            backgroundColor: backgroundColor,
            specieDescription: context
                .read<PokedexCubit>()
                .findSpecieDescriptionPokemon(state, pokemon.id),
            pokemonSpecieModel: pokemonSpecieModel,
          ),
        ),
      ),
    );
  }
}
