import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_cubit.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_state.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokemon_detail_info.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokemon_header_info.dart';
import 'package:flutter_application_1/app/modules/pokemon_capture/widgets/pokeball_animation_capture.dart';

import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showPokemonModal({
  required BuildContext context,
  required Color backgroundColor,
  required PokemonModel pokemon,
  required PokedexState state,
}) {
  void closeDialog(BuildContext context) {
    Navigator.pop(context);
  }

  void performCubitAction(PokemonSpecieModel? pokemonSpecieModel) {
    context
        .read<PokedexCubit>()
        .updatePokemonCaptureStatus(pokemon.id, pokemonSpecieModel, true);
  }

  void goToNewScreen(BuildContext context) {
    context.pushTransparentRoute(
      const PokeballAnimationCapture(),
    );
  }

  void handleUserAction(
      BuildContext context, PokemonSpecieModel? pokemonSpecieModel) {
    closeDialog(context);
    performCubitAction(pokemonSpecieModel);
    goToNewScreen(context);
  }

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
              .firstWhere((pokemonSpecie) => pokemonSpecie!.id == pokemon.id);
          specieDescription = pokemonSpecieModel!.getFlavorTextInSpanish()!;
        }

        return ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
              maxWidth: MediaQuery.of(context).size.width),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    PokemonHeaderInfo(
                        backgroundColor: backgroundColor, pokemon: pokemon),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 20),
                      child: Center(
                        child: Transform.scale(
                          scale: 0.9,
                          child: Image.network(
                              pokemon.sprites!.other!.home!.frontDefault!,
                              cacheWidth: 300,
                              cacheHeight: 300,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                ),
                Transform.translate(
                  offset: const Offset(0.0, -20.0),
                  child: PokemonDetailInfo(
                    pokemon: pokemon,
                    pokemonSpecieModel: pokemonSpecieModel,
                    specieDescription: specieDescription,
                    backgroundColor: backgroundColor,
                    onTap: () => handleUserAction(context, pokemonSpecieModel),
                  ),
                ),
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
