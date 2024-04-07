import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme.dart';

class PokedexHeightAndWidthCard extends StatelessWidget {
  final int pokemonHeight;
  final int pokemonWidth;
  const PokedexHeightAndWidthCard(
      {super.key, required this.pokemonHeight, required this.pokemonWidth});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Wrap(
                children: [
                  Text(
                    'Height :',
                    style:
                        context.labelM!.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    pokemonHeight.toString(),
                    style: context.labelM!,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Wrap(
                children: [
                  Text(
                    'Weight :',
                    style:
                        context.titleS!.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Transform.translate(
                    offset: const Offset(0.5, 0.0),
                    child: Text(
                      '${pokemonWidth.toStringAsFixed(1)}lbs',
                      style: context.titleS!,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
