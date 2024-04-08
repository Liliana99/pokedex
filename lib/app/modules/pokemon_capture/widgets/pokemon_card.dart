import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_state.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokemon_detail_info.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokemon_header_info.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_application_1/theme/theme.dart';

class PokemonCardCaptured extends StatelessWidget {
  const PokemonCardCaptured(
      {super.key,
      this.backgroundColor,
      this.onTap,
      required this.pokemon,
      required this.state,
      this.specieDescription,
      this.pokemonSpecieModel});

  final Color? backgroundColor;
  final VoidCallback? onTap;
  final PokemonModel pokemon;
  final PokedexState state;
  final String? specieDescription;
  final PokemonSpecieModel? pokemonSpecieModel;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: backgroundColor!,
      child: InkWell(
        onTap: onTap?.call,
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
