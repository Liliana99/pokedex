import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_state.dart';
import 'package:flutter_application_1/consts/shared_preferences_constants.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_application_1/shared/provider/storage_provider.dart';
import 'package:flutter_application_1/shared/repositories/cache_utils/cache_manager_repository.dart';
import 'package:flutter_application_1/shared/repositories/pokemon_repository.dart/fetch_pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:collection/collection.dart';

class PokedexCubit extends Cubit<PokedexState> {
  final PokemonRepository pokemonRepository;

  PokedexCubit(this.pokemonRepository) : super(const PokedexState());

  Future<void> loadPokemons() async {
    List<PokemonModel?>? pokemonList;
    try {
      pokemonList = await CacheManagerRepository()
          .loadPokemonList(keyListName: 'pokemonModelList');

      if (pokemonList != null && pokemonList.isNotEmpty) {
        emit(
          state.copyWith(
            pokemons: pokemonList,
            isLoading: false,
          ),
        );
        updatePokemonSpecie(pokemonList);
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

  Future<void> cacheCurrentPokemonList(List<dynamic>? pokemonList) async {
    if (Platform.isAndroid || Platform.isIOS) {
      await CacheManagerRepository().writeOnCachePokemonList(pokemonList!,
          keyListName: 'pkemonSpecieList');
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
          await CacheManagerRepository().writeOnCachePokemonSpecieList(
              speciesList,
              keyListName: SharedPreferencesConstants.keyPokemonSpeciesList);
        }
      }
    }
    return speciesList;
  }

  Future<void> updatePokemonCaptureStatus(
      int pokemonId, PokemonSpecieModel? specieModel, bool isCaptured) async {
    StorageProvider? storage = StorageProvider();
    WidgetsFlutterBinding.ensureInitialized();
    try {
      if (storage.prefs == null) {
        await storage.init();
      }
      PokemonModel? pokemonFound = findItemInList(pokemonId, state.pokemons!);

      if (pokemonFound != null || pokemonFound!.id > 0) {
        List<PokemonModel> pokemonsCapturedList =
            await storage.loadPokemonListCaptured(
                keyListName: SharedPreferencesConstants.keyPokemonCapturedList);

        if (pokemonFound.id == pokemonId) {
          pokemonFound.copyWith(isCaptured: isCaptured);
        }
        if (pokemonsCapturedList.isNotEmpty) {
          PokemonModel? pokemon =
              findItemInList(pokemonId, state.capturedPokemons!);
          if (pokemon == null) {
            pokemonsCapturedList.add(pokemonFound);
            emit(state.copyWith(capturedPokemons: pokemonsCapturedList));
          }
        } else {
          pokemonsCapturedList.add(pokemonFound);
          emit(state.copyWith(capturedPokemons: pokemonsCapturedList));
        }

        storage.savePokemonListCaptured(pokemonsCapturedList,
            keyListName: SharedPreferencesConstants.keyPokemonCapturedList);
      }
    } on Exception catch (e) {
      if (e.toString().contains('Bad state')) {
      } else {
        print('updatePokemonCaptureStatus ${e.toString()}');
      }
    }
  }

  PokemonModel? findItemInList(int id, List<PokemonModel?>? listPokemons) {
    if (listPokemons!.isEmpty) return null;
    return listPokemons.firstWhereOrNull(
      (pokemon) => pokemon!.id == id,
    );
  }

  void showAppBar() => emit(
        state.copyWith(
          isScrolled: false,
        ),
      );
  void hideAppBar() => emit(state.copyWith(isScrolled: true, isStarted: false));
  void showAppBarWithStatus(final bool isCollapse) =>
      emit(state.copyWith(isStarted: isCollapse));

  Future<void> loadLocalCapturedPokemons() async {
    StorageProvider? storage = StorageProvider();
    List<PokemonModel> pokemonList = [];

    List<PokemonSpecieModel> pokemonSpecieList = [];
    WidgetsFlutterBinding.ensureInitialized();
    try {
      if (storage.prefs == null) {
        await storage.init();
      }
      pokemonList = await storage.loadPokemonListCaptured(
          keyListName: SharedPreferencesConstants.keyPokemonCapturedList);
      pokemonSpecieList = await storage.loadPokemonSpecieList(
          keyListName: SharedPreferencesConstants.keyPokemonSpeciesList);
      emit(state.copyWith(
          capturedPokemons: pokemonList, pokemonSpecie: pokemonSpecieList));
    } on Exception catch (e) {
      print(e.toString());
    } finally {}
  }

  String? findSpecieDescriptionPokemon(
      PokedexState stateFromPage, int pokemonId) {
    try {
      if (stateFromPage.pokemonSpecie != null &&
          stateFromPage.pokemonSpecie!.isNotEmpty &&
          pokemonId > 0) {
        PokemonSpecieModel? specie = stateFromPage.pokemonSpecie!
            .firstWhereOrNull((element) => element!.id == pokemonId);

        if (specie != null) {
          return specie.getFlavorTextInSpanish()!;
        }
      }
    } on Exception catch (e) {
      print('findSpecieDescriptionPokemon ${e.toString()}');
    }
    return '';
  }
}
