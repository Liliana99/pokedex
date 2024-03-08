import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:path_provider/path_provider.dart';

class CacheManagerRepository {
  Future<void> writeCachedJsonPokemonBody(Map<String, dynamic>? body) async {
    const String fileName = 'pathString.json';
    final Directory directory = await getTemporaryDirectory();
    final File file = File('${directory.path}/$fileName');
    if (body != null) {
      final String jsonString = jsonEncode(body);
      await file.writeAsString(jsonString, flush: true);
    }
  }

  Future<Map<String, dynamic>?> readCachedJsonPokemonBody() async {
    if (Platform.isAndroid || Platform.isIOS) {
      const String fileName = 'pathString.json';
      final Directory directory = await getTemporaryDirectory();
      final File file = File('${directory.path}/$fileName');

      if (file.existsSync()) {
        final String data = await file.readAsString();
        if (data.isNotEmpty) {
          final Map<String, dynamic> decodedData = jsonDecode(data);
          return decodedData;
        }
      }
    }

    return null;
  }

  Future<void> writeOnCachePokemonList(List<PokemonModel?>? pokemons) async {
    final Directory directory = await getTemporaryDirectory();
    final File file = File('${directory.path}/pathPokemonList.json');

    if (pokemons != null) {
      final String jsonString = jsonEncode(pokemons);
      await file.writeAsString(jsonString, flush: true);
    }
  }

  Future<List<PokemonModel?>?> obtainCachedPokemonList() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final Directory directory = await getTemporaryDirectory();
      final File file = File('${directory.path}/pathPokemonList.json');

      if (await file.exists()) {
        final String jsonString = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        final List<PokemonModel?> pokemons = jsonList
            .map((jsonItem) => PokemonModel.fromJson(jsonItem))
            .toList();
        return pokemons;
      }
    }

    return null;
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
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }
}
