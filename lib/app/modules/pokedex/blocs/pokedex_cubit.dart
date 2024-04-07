import 'dart:io';

import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_state.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_application_1/shared/repositories/cache_utils/cache_manager_repository.dart';
import 'package:flutter_application_1/shared/repositories/pokemon_repository.dart/fetch_pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class PokedexCubit extends Cubit<PokedexState> {
  final PokemonRepository pokemonRepository;

  PokedexCubit(this.pokemonRepository) : super(const PokedexState());

  Future<void> loadPokemons() async {
    List<PokemonModel?>? pokemonList;
    try {
      pokemonList = await CacheManagerRepository().loadPokemonList();
      if (pokemonList != null && pokemonList.isNotEmpty) {
        emit(
          state.copyWith(
            pokemons: pokemonList,
            isLoading: false,
          ),
        );
      } else {
        fetchAndUpdatePokemonList();
      }
    } on MissingPlatformDirectoryException catch (_) {
      if (!state.isFiltered!) {
        fetchAndUpdatePokemonList();
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

  void fetchAndUpdatePokemonList() async {
    emit(state.copyWith(isLoading: true, isFiltered: false));
    List<PokemonModel?>? pokemonList =
        await PokemonRepository().fetchPokemons();
    if (pokemonList != null) {
      final List<PokemonSpecieModel> initialSpeciesList =
          await _fetchSpeciesForPokemons(pokemonList);

      emit(
        state.copyWith(
            isLoading: false,
            pokemons: pokemonList,
            pokemonSpecie: initialSpeciesList,
            isPokemonLoadSuccess: true),
      );
      if (pokemonList.length >= 10) {
        await updatePokemonList(); // Initial data
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

  void onPokemonSpecieFetched(PokemonSpecieModel pokemonSpecieModel) {
    final List<PokemonSpecieModel> pokemonSpecieList =
        List.from(state.pokemonSpecie ?? [])..add(pokemonSpecieModel);
    emit(state.copyWith(pokemonSpecie: pokemonSpecieList));
  }

  Future<void> updatePokemonList() async {
    await pokemonRepository.fetchAndUpdateList(
        onPokemonFetched, onPokemonSpecieFetched);
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
          .toList();

      if (filteredPokemons.isNotEmpty) {
        filteredPokemons.sort();
        emit(state.copyWith(
            filteredPokemons: filteredPokemons,
            isFiltered: true,
            isLoading: false));
      } else {
        emit(state.copyWith(
            filteredPokemons: [], isFiltered: false, isLoading: false));
      }
    }
  }

  Future<void> updatePokemonSpecie(List<PokemonModel?>? pokemonList) async {
    final List<PokemonSpecieModel> updatedSpeciesList =
        await _fetchSpeciesForPokemons(pokemonList!);
    List<PokemonSpecieModel>? initialSpecieList =
        List<PokemonSpecieModel>.from(state.pokemonSpecie ?? []);
    initialSpecieList.addAll(updatedSpeciesList);
    emit(state.copyWith(pokemonSpecie: initialSpecieList));
    await cacheCurrentPokemonList();
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

  void updatePokemonCaptureStatus(int pokemonId, bool isCaptured) {
    PokemonModel? pokemonFound = findItemInList(pokemonId, state.pokemons!);

    if (pokemonFound != null || pokemonFound!.id > 0) {
      List<PokemonModel> pokemonsCapturedList =
          List.from(state.capturedPokemons ?? []);
      if (pokemonFound.id == pokemonId) {
        pokemonFound.copyWith(isCaptured: isCaptured);
        pokemonsCapturedList.add(pokemonFound);
      }
      if (pokemonsCapturedList.isNotEmpty) {
        if (state.capturedPokemons != null &&
            state.capturedPokemons!.isNotEmpty) {
          var pokemon = findItemInList(pokemonId, state.capturedPokemons!);
          if (pokemon == null || pokemon.id == -1) {
            emit(state.copyWith(capturedPokemons: pokemonsCapturedList));
          }
        } else {
          emit(state.copyWith(capturedPokemons: pokemonsCapturedList));
        }
      }
    }
  }

  PokemonModel? findItemInList(int id, List<PokemonModel?>? listPokemons) {
    if (listPokemons!.isEmpty) return null;
    return listPokemons.firstWhere((pokemon) => pokemon!.id == id,
        orElse: () => const PokemonModel('', -1, -1, -1, null, -1, -1, null,
            null, null, null, null, null, null, null, null, null, null, null));
  }

  void showAppBar() => emit(
        state.copyWith(
          isScrolled: false,
        ),
      );
  void hideAppBar() => emit(state.copyWith(isScrolled: true, isStarted: false));
  void showAppBarWithStatus(final bool isCollapse) =>
      emit(state.copyWith(isStarted: isCollapse));
}
