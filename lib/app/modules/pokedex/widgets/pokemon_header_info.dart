import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_application_1/theme/theme.dart';

class PokemonHeaderInfo extends StatelessWidget {
  const PokemonHeaderInfo({
    super.key,
    required this.backgroundColor,
    required this.pokemon,
  });
  final Color backgroundColor;
  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(12),
                child: ClipPath(
                  clipper: WaveClipperTwo(
                    flip: true,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.lerp(backgroundColor, Colors.white, 0.5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                      ),
                    ),
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        pokemon.name,
                        style: context.bodyL!.copyWith(
                            color: Colors.black45,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 8),
                child: Text(
                  '#${pokemon.id.toString()}',
                  style: context.bodyM!.copyWith(
                      color: Colors.black26,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
