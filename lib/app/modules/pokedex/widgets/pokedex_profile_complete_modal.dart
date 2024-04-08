import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_cubit.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_state.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokeball_vibrate.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokemon_detail_info.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokemon_header_info.dart';
import 'package:flutter_application_1/app/modules/pokemon_capture/pages/widgets/pokeball_animation_capture.dart';

import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showPokemonModal({
  required BuildContext context,
  required Color backgroundColor,
  required PokemonModel pokemon,
  required PokedexState state,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: backgroundColor,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
    ),
    builder: (
      BuildContext context,
    ) {
      String? specieDescription;
      PokemonSpecieModel? pokemonSpecieModel;
      if (pokemon.id > 0) {
        if (state.pokemonSpecie != null && state.pokemonSpecie!.isNotEmpty) {
          pokemonSpecieModel = state.pokemonSpecie!
              .firstWhere((pokemonSpecie) => pokemonSpecie.id == pokemon.id);
          specieDescription = pokemonSpecieModel.getFlavorTextInSpanish()!;
        }

        return ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.80,
              maxWidth: MediaQuery.of(context).size.width),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    PokemonHeaderInfo(
                        backgroundColor: backgroundColor, pokemon: pokemon),
                    Row(
                      children: [
                        Expanded(
                          child: Transform.scale(
                            scale: 0.9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Transform.translate(
                                offset: const Offset(0.0, 1.25),
                                child: Center(
                                  child: Image.network(
                                      pokemon
                                          .sprites!.other!.home!.frontDefault!,
                                      cacheWidth: 300,
                                      cacheHeight: 300,
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                        ),
                        PokeballVibrate(
                          onTap: () {
                            context
                                .read<PokedexCubit>()
                                .updatePokemonCaptureStatus(pokemon.id, true);

                            context.pushTransparentRoute(
                              const PokeballAnimationCapture(),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                PokemonDetailInfo(
                  pokemon: pokemon,
                  pokemonSpecieModel: pokemonSpecieModel,
                  specieDescription: specieDescription,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }

      return const CircularProgressIndicator();
    },
  );
}

class UpperLeftRoundedClipper extends CustomClipper<Path> {
  final double radius;

  UpperLeftRoundedClipper({this.radius = 30.0});

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, radius);
    path.arcToPoint(
      Offset(radius, 0),
      radius: Radius.circular(radius),
      clockwise: false,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // Si el radio se actualiza, entonces devuelve true
  }
}
