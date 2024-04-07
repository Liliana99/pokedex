import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokedex_profile_card.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';

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
          Text(
            specieDescription ?? '',
            style: const TextStyle(color: Colors.black54),
            textAlign: TextAlign.justify,
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
            child: Row(
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
    );
  }
}