import 'dart:convert';

import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider {
  SharedPreferences? prefs;
  String keyList = "pokemons";

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> savePokemonList(List<PokemonModel> pokemonList) async {
    List<String> jsonList = pokemonList
        .map(
          (model) => json.encode(
            model.toJson(),
          ),
        )
        .toList();
    return prefs!.setStringList(keyList, jsonList);
  }

  Future<bool> savePokemonSpecieList(List<PokemonSpecieModel> pokemonSpecieList,
      {required String keyListName}) async {
    List<String> jsonList = pokemonSpecieList
        .map(
          (model) => json.encode(
            model.toJson(),
          ),
        )
        .toList();
    return prefs!.setStringList(keyListName, jsonList);
  }

  Future<bool> savePokemonListCaptured(List<PokemonModel> pokemonList,
      {required String keyListName}) async {
    List<String> jsonList = pokemonList
        .map(
          (model) => json.encode(
            model.toJson(),
          ),
        )
        .toList();
    return prefs!.setStringList(keyListName, jsonList);
  }

  Future<List<PokemonModel>> loadPokemonList() async {
    List<String>? jsonList = prefs!.getStringList(keyList);
    if (jsonList == null) return [];
    return jsonList
        .map((jsonItem) => PokemonModel.fromJson(json.decode(jsonItem)))
        .toList();
  }

  Future<List<PokemonModel>> loadPokemonListCaptured(
      {required String keyListName}) async {
    List<String>? jsonList = prefs!.getStringList(keyListName);
    if (jsonList == null) return [];
    return jsonList
        .map((jsonItem) => PokemonModel.fromJson(json.decode(jsonItem)))
        .toList();
  }

  Future<List<PokemonSpecieModel>> loadPokemonSpecieList(
      {required String keyListName}) async {
    List<String>? jsonList = prefs!.getStringList(keyListName);
    if (jsonList == null) return [];
    return jsonList
        .map((jsonItem) => PokemonSpecieModel.fromJson(json.decode(jsonItem)))
        .toList();
  }

  Future<bool> updatePokemonList(List<PokemonModel> pokemonList) async {
    return await savePokemonList(pokemonList);
  }

  Future<bool> deletePokemonList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(keyList);
  }
}
