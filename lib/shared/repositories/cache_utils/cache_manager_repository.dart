import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManagerRepository {
  Future<void> writeCachedJsonPokemonBody(Map<String, dynamic>? body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    const String key = 'pathString.json';

    String? jsonString = body != null ? jsonEncode(body) : null;

    if (jsonString != null) {
      await prefs.setString(key, jsonString);
    } else {
      await prefs.remove(key);
    }
  }

  Future<Map<String, dynamic>?> readCachedJsonPokemonBody() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    const String key = 'pathString.json';
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  Future<void> writeOnCachePokemonList(List<PokemonModel?>? pokemons) async {
    if (pokemons == null || pokemons.isEmpty) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> pokemonListString = pokemons.map((pokemon) {
      return jsonEncode(pokemon?.toJson() ?? {});
    }).toList();
    await prefs.setStringList('pokemon_list', pokemonListString);
  }

  Future<List<PokemonModel?>?> loadPokemonList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? pokemonListString = prefs.getStringList('pokemon_list');

    if (pokemonListString == null) {
      return [];
    }

    List<PokemonModel?> pokemons = pokemonListString.map((pokemonString) {
      try {
        final Map<String, dynamic> pokemonMap = jsonDecode(pokemonString);
        return PokemonModel.fromJson(pokemonMap);
      } catch (e) {
        return null;
      }
    }).toList();

    return pokemons;
  }

  Future<bool> isPokemonListCached() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        final Directory directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/pathPokemonList.json');
        if (file.existsSync()) {
          final String content = await file.readAsString();
          if (content.isNotEmpty && content != "[]") {
            return true;
          }
        }
      }
      return false;
    } on Exception catch (_) {}
    return false;
  }
}
