// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PokedexStateCWProxy {
  PokedexState pokemons(List<PokemonModel?>? pokemons);

  PokedexState filteredPokemons(List<PokemonModel?>? filteredPokemons);

  PokedexState capturedPokemons(List<PokemonModel?>? capturedPokemons);

  PokedexState isLoading(bool? isLoading);

  PokedexState isFiltered(bool? isFiltered);

  PokedexState pokemonSpecie(List<PokemonSpecieModel?>? pokemonSpecie);

  PokedexState error(String? error);

  PokedexState isPokemonLoadfailure(bool? isPokemonLoadfailure);

  PokedexState isPokemonLoadSuccess(bool? isPokemonLoadSuccess);

  PokedexState isScrolled(bool? isScrolled);

  PokedexState isStarted(bool? isStarted);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PokedexState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PokedexState(...).copyWith(id: 12, name: "My name")
  /// ````
  PokedexState call({
    List<PokemonModel?>? pokemons,
    List<PokemonModel?>? filteredPokemons,
    List<PokemonModel?>? capturedPokemons,
    bool? isLoading,
    bool? isFiltered,
    List<PokemonSpecieModel?>? pokemonSpecie,
    String? error,
    bool? isPokemonLoadfailure,
    bool? isPokemonLoadSuccess,
    bool? isScrolled,
    bool? isStarted,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPokedexState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPokedexState.copyWith.fieldName(...)`
class _$PokedexStateCWProxyImpl implements _$PokedexStateCWProxy {
  const _$PokedexStateCWProxyImpl(this._value);

  final PokedexState _value;

  @override
  PokedexState pokemons(List<PokemonModel?>? pokemons) =>
      this(pokemons: pokemons);

  @override
  PokedexState filteredPokemons(List<PokemonModel?>? filteredPokemons) =>
      this(filteredPokemons: filteredPokemons);

  @override
  PokedexState capturedPokemons(List<PokemonModel?>? capturedPokemons) =>
      this(capturedPokemons: capturedPokemons);

  @override
  PokedexState isLoading(bool? isLoading) => this(isLoading: isLoading);

  @override
  PokedexState isFiltered(bool? isFiltered) => this(isFiltered: isFiltered);

  @override
  PokedexState pokemonSpecie(List<PokemonSpecieModel?>? pokemonSpecie) =>
      this(pokemonSpecie: pokemonSpecie);

  @override
  PokedexState error(String? error) => this(error: error);

  @override
  PokedexState isPokemonLoadfailure(bool? isPokemonLoadfailure) =>
      this(isPokemonLoadfailure: isPokemonLoadfailure);

  @override
  PokedexState isPokemonLoadSuccess(bool? isPokemonLoadSuccess) =>
      this(isPokemonLoadSuccess: isPokemonLoadSuccess);

  @override
  PokedexState isScrolled(bool? isScrolled) => this(isScrolled: isScrolled);

  @override
  PokedexState isStarted(bool? isStarted) => this(isStarted: isStarted);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PokedexState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PokedexState(...).copyWith(id: 12, name: "My name")
  /// ````
  PokedexState call({
    Object? pokemons = const $CopyWithPlaceholder(),
    Object? filteredPokemons = const $CopyWithPlaceholder(),
    Object? capturedPokemons = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isFiltered = const $CopyWithPlaceholder(),
    Object? pokemonSpecie = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? isPokemonLoadfailure = const $CopyWithPlaceholder(),
    Object? isPokemonLoadSuccess = const $CopyWithPlaceholder(),
    Object? isScrolled = const $CopyWithPlaceholder(),
    Object? isStarted = const $CopyWithPlaceholder(),
  }) {
    return PokedexState(
      pokemons: pokemons == const $CopyWithPlaceholder()
          ? _value.pokemons
          // ignore: cast_nullable_to_non_nullable
          : pokemons as List<PokemonModel?>?,
      filteredPokemons: filteredPokemons == const $CopyWithPlaceholder()
          ? _value.filteredPokemons
          // ignore: cast_nullable_to_non_nullable
          : filteredPokemons as List<PokemonModel?>?,
      capturedPokemons: capturedPokemons == const $CopyWithPlaceholder()
          ? _value.capturedPokemons
          // ignore: cast_nullable_to_non_nullable
          : capturedPokemons as List<PokemonModel?>?,
      isLoading: isLoading == const $CopyWithPlaceholder()
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool?,
      isFiltered: isFiltered == const $CopyWithPlaceholder()
          ? _value.isFiltered
          // ignore: cast_nullable_to_non_nullable
          : isFiltered as bool?,
      pokemonSpecie: pokemonSpecie == const $CopyWithPlaceholder()
          ? _value.pokemonSpecie
          // ignore: cast_nullable_to_non_nullable
          : pokemonSpecie as List<PokemonSpecieModel?>?,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as String?,
      isPokemonLoadfailure: isPokemonLoadfailure == const $CopyWithPlaceholder()
          ? _value.isPokemonLoadfailure
          // ignore: cast_nullable_to_non_nullable
          : isPokemonLoadfailure as bool?,
      isPokemonLoadSuccess: isPokemonLoadSuccess == const $CopyWithPlaceholder()
          ? _value.isPokemonLoadSuccess
          // ignore: cast_nullable_to_non_nullable
          : isPokemonLoadSuccess as bool?,
      isScrolled: isScrolled == const $CopyWithPlaceholder()
          ? _value.isScrolled
          // ignore: cast_nullable_to_non_nullable
          : isScrolled as bool?,
      isStarted: isStarted == const $CopyWithPlaceholder()
          ? _value.isStarted
          // ignore: cast_nullable_to_non_nullable
          : isStarted as bool?,
    );
  }
}

extension $PokedexStateCopyWith on PokedexState {
  /// Returns a callable class that can be used as follows: `instanceOfPokedexState.copyWith(...)` or like so:`instanceOfPokedexState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PokedexStateCWProxy get copyWith => _$PokedexStateCWProxyImpl(this);
}
