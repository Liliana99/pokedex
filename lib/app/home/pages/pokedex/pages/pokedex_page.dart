import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/home/pages/pokedex/blocs/pokedex_cubit.dart';
import 'package:flutter_application_1/app/home/pages/pokedex/blocs/pokedex_state.dart';
import 'package:flutter_application_1/app/home/pages/pokedex/widgets/app_bar.dart';
import 'package:flutter_application_1/app/home/pages/pokedex/widgets/pokedex_card.dart';
import 'package:flutter_application_1/app/home/pages/pokedex/widgets/pokedex_detail_modal.dart';
import 'package:flutter_application_1/app/home/pages/pokedex/widgets/search_widget.dart';
import 'package:flutter_application_1/shared/widgets/pokemon_indicator_loading.dart';
import 'package:flutter_application_1/utils/obtain_pokemon_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokedexPage extends StatelessWidget {
  const PokedexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PokedexContent();
  }
}

class _PokedexContent extends StatelessWidget {
  const _PokedexContent();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PokedexCubit, PokedexState>(
        listener: (context, state) {
          if (state.isLoading! && state.isFiltered == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Se están descargando los Pokémons...'),
                duration:
                    Duration(seconds: 2), // Ajusta la duración según necesites
              ),
            );
          }
        },
        child: BlocBuilder<PokedexCubit, PokedexState>(
          builder: (context, state) {
            if (state.isLoading! && state.isFiltered == false) {
              return const Center(child: PokemonLoading());
            }
            if (state.error != null && state.error!.isNotEmpty) {
              return const Center(child: Text(''));
            }

            return NestedScrollView(
              headerSliverBuilder: (_, __) => [
                AppMovingTitleSliverAppBar(
                  title: 'Pokedex',
                  search: CustomSearchWidget(
                    onPressed: (value) =>
                        context.read<PokedexCubit>().searchAndSort(value),
                  ),
                ),
              ],
              body: PokemonGrid(
                state: state,
              ),
            );
          },
        ),
      ),
    );
  }
}

class PokemonGrid extends StatelessWidget {
  final PokedexState state;
  const PokemonGrid({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(28),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              final pokemon = state.isFiltered!
                  ? state.filteredPokemons![index]
                  : state.pokemons![index];
              Color pokemonBackgroundColor =
                  findPokemonTypeColor(pokemon!.types!.first.type!.name!);

              return PokeDexCard(
                  backgroundColor: pokemonBackgroundColor,
                  pokemon: pokemon,
                  onTap: () async {
                    showPokemonModal(
                      context: context,
                      backgroundColor: pokemonBackgroundColor,
                      pokemon: pokemon,
                    );
                  });
            },
                childCount: state.isFiltered!
                    ? state.filteredPokemons!.length
                    : state.pokemons!.length),
          ),
        ),
      ],
    );
  }
}
