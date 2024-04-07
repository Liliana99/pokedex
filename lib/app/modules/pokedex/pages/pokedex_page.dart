import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_cubit.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_state.dart';
import 'package:flutter_application_1/shared/widgets/app_bar.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokedex_card.dart';
import 'package:flutter_application_1/app/modules/pokedex/widgets/pokedex_profile_complete_modal.dart';
import 'package:flutter_application_1/shared/widgets/search_widget.dart';
import 'package:flutter_application_1/shared/widgets/pokemon_indicator_loading.dart';
import 'package:flutter_application_1/utils/obtain_pokemon_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late ScrollController _scrollController;
  late PokedexCubit _pokedexCubit;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _pokedexCubit = BlocProvider.of<PokedexCubit>(context);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    _pokedexCubit.showAppBar();
    _pokedexCubit.showAppBarWithStatus(true);
    if (_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _scrollController.addListener(() {
          //isScrolling

          _pokedexCubit.hideAppBar();
        });
        _scrollController.position.isScrollingNotifier.addListener(() {
          if (!_scrollController.position.isScrollingNotifier.value) {
            //isStopped
            _pokedexCubit.showAppBar();
            _pokedexCubit
                .showAppBarWithStatus(_scrollController.position.pixels == 0);
          } else {
            //isScrolling
            _pokedexCubit.hideAppBar();
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokedexCubit, PokedexState>(
      builder: (context, state) {
        return _PokedexContent(_pokedexCubit, _scrollController);
      },
    );
  }
}

class _PokedexContent extends StatelessWidget {
  final PokedexCubit cubit;
  final ScrollController controller;
  const _PokedexContent(this.cubit, this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PokedexCubit, PokedexState>(
        builder: (context, state) {
          if (state.isLoading! && state.isFiltered == false) {
            return const Center(child: PokemonLoading());
          }
          if (state.error != null && state.error!.isNotEmpty) {
            return const Center(
              child: Text(''),
            );
          }
          return NestedScrollView(
            controller: controller,
            headerSliverBuilder: (_, __) => [
              AppMovingTitleSliverAppBar(
                title: 'Pokedex',
                state: state,
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
                        state: state);
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
