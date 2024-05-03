import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokeball_vibrate.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokedex_profile_card.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class PokemonDetailInfo extends StatelessWidget {
  const PokemonDetailInfo(
      {super.key,
      this.pokemonSpecieModel,
      this.specieDescription,
      required this.pokemon,
      required this.backgroundColor,
      this.onTap});
  final PokemonSpecieModel? pokemonSpecieModel;
  final String? specieDescription;
  final PokemonModel pokemon;
  final Color backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const Color titleColor = Colors.black54;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
      child: Column(
        children: [
          Wrap(
            children: [
              Text(
                specieDescription ?? '',
                style: context.labelL!.copyWith(color: Colors.black87),
                textAlign: TextAlign.justify,
                textScaler: const TextScaler.linear(0.9),
                maxLines: 10,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: PokedexHeightAndWidthCard(
              pokemonHeight: pokemon.height!,
              pokemonWidth: pokemon.weight!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: ClipPath(
                clipper: MultiplePointedEdgeClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.lerp(backgroundColor, Colors.white, 0.3),
                  ),
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'Egg Groups',
                                style: TextStyle(
                                    color: titleColor,
                                    fontWeight: FontWeight.w600),
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
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Text(
                                  'Capturar',
                                  style: context.labelL!
                                      .copyWith(color: titleColor),
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24),
                                      child: PokeballVibrate(
                                        onTap: onTap?.call,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
