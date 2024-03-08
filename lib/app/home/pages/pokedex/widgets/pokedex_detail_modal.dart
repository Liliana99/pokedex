import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/home/pages/pokedex/blocs/pokedex_cubit.dart';
import 'package:flutter_application_1/app/home/pages/pokedex/blocs/pokedex_state.dart';
import 'package:flutter_application_1/app/home/pages/pokedex/widgets/pokedex_detail_card.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showPokemonModal({
  required BuildContext context,
  required Color backgroundColor,
  required PokemonModel pokemon,
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
      return BlocBuilder<PokedexCubit, PokedexState>(builder: (
        BuildContext context,
        PokedexState state,
      ) {
        String? specieDescription;
        PokemonSpecieModel? pokemonSpecieModel;

        if (state.pokemonSpecie != null && state.pokemonSpecie!.isNotEmpty) {
          pokemonSpecieModel = state.pokemonSpecie![pokemon.id];
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
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 24, left: 12, right: 12, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                pokemon.name,
                                style: context.dispM!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8, top: 4),
                              child: Text(
                                '#${pokemon.id.toString()}',
                                style: context.dispM!
                                    .copyWith(color: Colors.black26),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 12),
                        child: Center(
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
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                  child: Column(
                    children: [
                      Text(
                        specieDescription ?? '',
                        style: const TextStyle(color: Colors.black54),
                        textAlign: TextAlign.justify,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 36),
                        child: PokedexHeightAndWidthCard(
                          pokemonHeight: pokemon.height!,
                          pokemonWidth: pokemon.weight!,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            const Text(
                              'Egg Groups',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600),
                            ),
                            if (pokemonSpecieModel != null)
                              Wrap(
                                spacing: 2.0,
                                runSpacing: 1.5,
                                direction: Axis.horizontal,
                                children: pokemonSpecieModel.eggGroups!
                                    .map(
                                      (specie) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(specie.name!),
                                      ),
                                    )
                                    .toList(),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      });
    },
  );
}
