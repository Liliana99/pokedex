import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokedex_profile_card.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_application_1/theme/theme.dart';

class PokemonDetailInfo extends StatelessWidget {
  const PokemonDetailInfo(
      {super.key,
      this.pokemonSpecieModel,
      this.specieDescription,
      required this.pokemon});
  final PokemonSpecieModel? pokemonSpecieModel;
  final String? specieDescription;
  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
      child: Column(
        children: [
          Wrap(
            children: [
              Text(
                specieDescription ?? '',
                style: context.labelL!.copyWith(color: Colors.black54),
                textAlign: TextAlign.justify,
                textScaler: const TextScaler.linear(0.9),
                maxLines: 10,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: PokedexHeightAndWidthCard(
              pokemonHeight: pokemon.height!,
              pokemonWidth: pokemon.weight!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Wrap(
              children: [
                Column(
                  children: [
                    const Text(
                      'Egg Groups',
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w600),
                    ),
                    if (pokemonSpecieModel!.eggGroups != null)
                      Wrap(
                        spacing: 2.0,
                        runSpacing: 1.5,
                        direction: Axis.horizontal,
                        children: pokemonSpecieModel!.eggGroups!
                            .map(
                              (specie) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(specie.name!,
                                    textAlign: TextAlign.left,
                                    style: context.labelM),
                              ),
                            )
                            .toList(),
                      )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
