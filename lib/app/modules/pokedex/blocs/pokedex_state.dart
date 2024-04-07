import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';

part 'pokedex_state.g.dart';

@CopyWith()
class PokedexState extends Equatable {
  final List<PokemonModel?>? pokemons;
  final List<PokemonModel?>? filteredPokemons;
  final List<PokemonModel?>? capturedPokemons;
  final List<PokemonSpecieModel>? pokemonSpecie;
  final bool? isLoading;
  final bool? isFiltered;
  final bool? isPokemonLoadfailure;
  final bool? isPokemonLoadSuccess;
  final bool? isScrolled;
  final bool? isStarted;
  final String? error;

  const PokedexState({
    this.pokemons,
    this.filteredPokemons,
    this.capturedPokemons,
    this.isLoading = false,
    this.isFiltered = false,
    this.pokemonSpecie,
    this.error,
    this.isPokemonLoadfailure,
    this.isPokemonLoadSuccess,
    this.isScrolled = false,
    this.isStarted = true,
  });

  @override
  List<Object?> get props => [
        pokemons,
        isLoading,
        isFiltered,
        capturedPokemons,
        error,
        filteredPokemons,
        pokemonSpecie,
        isPokemonLoadfailure,
        isPokemonLoadSuccess,
        isScrolled,
        isStarted,
      ];
}
