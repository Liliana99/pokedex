import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/home/pages/pokedex/widgets/pokedex_chip.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_application_1/theme/theme.dart';

class PokeDexCard extends StatelessWidget {
  final Color? backgroundColor;
  final PokemonModel? pokemon;
  final VoidCallback? onTap;

  const PokeDexCard(
      {super.key, this.backgroundColor, this.pokemon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: backgroundColor!,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4.0),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8, top: 4),
                    child: Text(
                      '#${pokemon!.id.toString()}',
                      style: context.labelM!.copyWith(color: Colors.black26),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      pokemon!.name,
                      style: context.labelM!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: Wrap(
                            runSpacing: -5,
                            spacing: -8,
                            direction: Axis.vertical,
                            children: pokemon!.types!
                                .map(
                                  (type) => PokedexChip(
                                    name: type.type!.name!,
                                    color: backgroundColor,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Image.network(
                            pokemon!.sprites!.other!.home!.frontDefault!,
                            cacheWidth: 100,
                            cacheHeight: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
