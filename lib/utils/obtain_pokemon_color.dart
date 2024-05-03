import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/pokemon_type_colors.dart';

Color? findPokemonTypeColor(String typeValue) {
  try {
    var matchValue = PokemonTypeNames.values.firstWhere(
      (element) => element.name.toLowerCase() == typeValue.toLowerCase(),
    );
    return Color(int.parse(findPokemonTypeByKeyValue(matchValue)));
  } on Exception catch (e) {
    print(e);
  }
  return null;
}

String findPokemonTypeByKeyValue(PokemonTypeNames keyName) {
  var foundKey = PokemonTypeColors.colours.entries.firstWhere(
    (mapEntry) => mapEntry.key == keyName,
  );
  return foundKey.value;
}
