import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/consts/assets_constants.dart';

class PokemonLoading extends StatelessWidget {
  const PokemonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(AssetsImagesConstants.pokedexLoadingImage));
  }
}
