import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:executor/executor.dart';
import 'package:flutter_application_1/consts/url_constants.dart';
import 'package:flutter_application_1/shared/blocs/error/error_cubit.dart';
import 'package:flutter_application_1/shared/intercepotors/rest_interceptor.dart';
import 'package:flutter_application_1/shared/models/pokemon_model.dart';
import 'package:flutter_application_1/shared/repositories/cache_utils/cache_manager_repository.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class PokemonRepository {
  Dio dio = Dio();

  static const String baseUrl = UrlConstants.baseUrl;

  var logger = Logger();

  PokemonRepository._privateConstructor({Dio? dioClient})
      : dio = dioClient ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 20),
              ),
            );

  static final PokemonRepository _instance =
      PokemonRepository._privateConstructor();

  factory PokemonRepository() {
    return _instance;
  }

  void init(ErrorCubit errorCubit) {
    dio.interceptors.clear();
    dio.interceptors.add(CustomInterceptor(responseHeader: false));
  }

  Future<List<PokemonModel?>?>? fetchPokemons() async {
    try {
      var pokemonModelsFromCache =
          await CacheManagerRepository().obtainCachedPokemonList();
      if (pokemonModelsFromCache != null && pokemonModelsFromCache.isNotEmpty) {
        return pokemonModelsFromCache;
      } else {
        var pokemonBody =
            await CacheManagerRepository().readCachedJsonPokemonBody();
        pokemonBody ??= await retrieveAndPokemonData();
        if (pokemonBody != null && pokemonBody['results'] != null) {
          return await fetchPokemonList(pokemonBody['results']);
        }
      }
    } on MissingPlatformDirectoryException catch (e) {
      var pokemonBody = await retrieveAndPokemonData();
      fetchPokemonList(pokemonBody!['results']);
    } catch (e) {
      logger.d(e);
      throw Exception('Failed to load Pokemons');
    }
    return null;
  }

  Future<List<PokemonModel?>?> fetchPokemonList(List<dynamic> pokemons) async {
    List<PokemonModel?>? pokemonsList = [];
    for (var pokemon in pokemons) {
      pokemonsList.add(await fetchPokemonData(pokemon['name']));
      if (pokemonsList.length >= 10) {
        break;
      }
    }
    return pokemonsList;
  }

  Future<PokemonModel?> fetchPokemonData(String name) async {
    String url = UrlConstants.pokemonUrl;
    url = url + name;

    try {
      Response pokemonResponse = await dio.get(url);
      PokemonModel pokemonModel;

      Map<String, dynamic> body = (pokemonResponse.data);
      if (pokemonResponse.statusCode == 200) {
        if (body['id'] != null) {
          pokemonModel = PokemonModel.fromJson(body);
          return pokemonModel;
        }
      }
    } catch (e) {
      logger.d('Exception when calling URL $url  $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> retrieveAndPokemonData() async {
    final response = await dio.get(baseUrl);
    if (response.statusCode == 200) {
      try {
        if (Platform.isAndroid || Platform.isIOS) {
          await CacheManagerRepository()
              .writeCachedJsonPokemonBody(response.data);
        }
      } finally {}
      return response.data;
    } else if (response.statusCode == 204) {
      logger.d('No content to return.');
      return null;
    } else {
      logger.d('Failed to load data: ${response.statusCode}');
    }
    return null;
  }

  Future<List<PokemonModel?>?> fetchAndUpdateList(
      Function(PokemonModel) onPokemonFetched) async {
    var pokemonBody =
        await CacheManagerRepository().readCachedJsonPokemonBody() ??
            await retrieveAndPokemonData();

    var pokemons = pokemonBody!['results'].sublist(10);
    final Executor executor = Executor(concurrency: 10);
    List<PokemonModel?>? pokemonsList = [];

    for (var pokemon in pokemons) {
      unawaited(
        executor.scheduleTask(
          () async {
            PokemonModel? pokemonModel =
                await fetchPokemonData(pokemon['name']!);
            onPokemonFetched(pokemonModel!);
          },
        ),
      );
    }
    await executor.join(withWaiting: true);
    await executor.close();
    return pokemonsList;
  }

  Future<PokemonSpecieModel?> fetchSpecies(String url) async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        PokemonSpecieModel? pokemonSpecie =
            PokemonSpecieModel.fromJson(response.data);
        return pokemonSpecie;
      }
      return null;
    } on DioException catch (e) {
      return null;
    }
  }
}
