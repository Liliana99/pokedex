import 'dart:io';

import 'package:flutter_application_1/app/home/pages/pokedex/blocs/pokedex_state.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_application_1/shared/repositories/cache_utils/cache_manager_repository.dart';
import 'package:flutter_application_1/shared/repositories/pokemon_repository.dart/fetch_pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class PokedexCubit extends Cubit<PokedexState> {
  final PokemonRepository pokemonRepository;

  PokedexCubit(this.pokemonRepository) : super(PokedexState());

  Future<void> loadPokemons() async {
    List<PokemonModel?>? pokemonList;
    try {
      if (await CacheManagerRepository().isPokemonListCached()) {
        emit(state.copyWith(isLoading: false, isFiltered: false));
        pokemonList = await CacheManagerRepository().obtainCachedPokemonList();
        emit(
          state.copyWith(
            pokemons: pokemonList,
          ),
        );
      } else {
        fetchAndUpdatePokemonList(pokemonList);
      }
    } on MissingPlatformDirectoryException catch (_) {
      if (!state.isFiltered!) {
        fetchAndUpdatePokemonList(pokemonList);
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
            isLoading: true,
            isFiltered: false,
            error: e.toString(),
            isPokemonLoadSuccess: false,
            isPokemonLoadfailure: true,
            pokemons: []),
      );
    }
  }

  void fetchAndUpdatePokemonList(List<PokemonModel?>? pokemonList) async {
    emit(state.copyWith(isLoading: true, isFiltered: false));
    pokemonList = await PokemonRepository().fetchPokemons();
    if (pokemonList != null) {
      final List<PokemonSpecieModel> initialSpeciesList =
          await _fetchSpeciesForPokemons(pokemonList);

      emit(state.copyWith(
          pokemons: pokemonList,
          pokemonSpecie: initialSpeciesList,
          isLoading: false,
          isPokemonLoadSuccess: true));

      if (pokemonList.length >= 10) {
        await updatePokemonList();
        final List<PokemonSpecieModel> updatedSpeciesList =
            await _fetchSpeciesForPokemons(pokemonList);
        List<PokemonSpecieModel>? initialSpecieList =
            List<PokemonSpecieModel>.from(state.pokemonSpecie ?? []);
        initialSpecieList.addAll(updatedSpeciesList);
        emit(state.copyWith(pokemonSpecie: initialSpecieList));
        await cacheCurrentPokemonList();
      }
    } else {
      emit(state.copyWith(isLoading: false, isPokemonLoadfailure: true));
    }
  }

  void onPokemonFetched(PokemonModel pokemonModel) {
    final List<PokemonModel?> updatedPokemonsList =
        List.from(state.pokemons ?? [])..add(pokemonModel);
    emit(state.copyWith(pokemons: updatedPokemonsList));
  }

  Future<void> updatePokemonList() async {
    await pokemonRepository.fetchAndUpdateList(onPokemonFetched);
  }

  Future<void> cacheCurrentPokemonList() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await CacheManagerRepository().writeOnCachePokemonList(state.pokemons!);
    }
  }

  void searchAndSort(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(isFiltered: false, isLoading: false));
      loadPokemons();
    } else {
      final List<PokemonModel?> pokemonList =
          List<PokemonModel>.from(state.pokemons ?? []);
      final List<PokemonModel?> filteredPokemons = pokemonList
          .where(
              (element) => element!.name.toLowerCase() == value.toLowerCase())
          .toList()
        ..sort();
      if (filteredPokemons.isNotEmpty) {
        emit(state.copyWith(
            filteredPokemons: filteredPokemons, isFiltered: true));
      } else {
        emit(state.copyWith(
            filteredPokemons: [], isFiltered: false, isLoading: false));
      }
    }
  }

  Future<List<PokemonSpecieModel>> _fetchSpeciesForPokemons(
      List<PokemonModel?> pokemonList) async {
    final List<PokemonSpecieModel> speciesList = [];
    for (final PokemonModel? pokemon in pokemonList) {
      if (pokemon?.species?.url != null) {
        final PokemonSpecieModel? specie =
            await pokemonRepository.fetchSpecies(pokemon!.species!.url!);
        if (specie != null) {
          speciesList.add(specie);
        }
      }
    }
    return speciesList;
  }
}
