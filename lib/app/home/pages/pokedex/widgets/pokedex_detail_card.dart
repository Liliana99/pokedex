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
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Height :',
                  style: context.titleS!.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  pokemonHeight.toString(),
                  style: context.titleS!,
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Text(
                  'Weight :',
                  style: context.titleS!.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${pokemonWidth.toStringAsFixed(1)} lbs',
                  style: context.titleS!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
