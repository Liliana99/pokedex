import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_cubit.dart';
import 'package:flutter_application_1/app/modules/pokedex/blocs/pokedex_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppMovingTitleSliverAppBar extends SliverAppBar {
  AppMovingTitleSliverAppBar({
    super.key,
    GlobalKey? appBarKey,
    String title = '',
    double height = kToolbarHeight + 48,
    double expandedFontSize = 30,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTrailingPressed,
    Widget? search,
    required PokedexState state,
  }) : super(
          expandedHeight: 150,
          pinned: true,
          floating: true,
          title: (!state.isScrolled! &&
                  state.isScrolled != null &&
                  !state.isStarted!)
              ? AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: state.isStarted! ? 1.0 : 0.0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: kToolbarHeight,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child:
                          search, // Muestra el widget de búsqueda cuando está expandido
                    ),
                  ),
                )
              : const Opacity(opacity: 0.0),
          flexibleSpace: BlocBuilder<PokedexCubit, PokedexState>(
            builder: (context, state) {
              return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;

                return FlexibleSpaceBar(
                  centerTitle: true,
                  title: (!state.isScrolled! &&
                          state.isScrolled != null &&
                          state.isStarted!)
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, state.isStarted! ? top * 0.4 : 80, 30, 0),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: 1.0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: kToolbarHeight),
                              child: Text(
                                title,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        )
                      : const Opacity(opacity: 0.0),
                  background: (!state.isScrolled! &&
                          state.isScrolled != null &&
                          state.isStarted!)
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(
                              30, state.isStarted! ? top * 0.4 : 80, 30, 0),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: state.isStarted! ? 1.0 : 0.0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: kToolbarHeight,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child:
                                    search, // Muestra el widget de búsqueda cuando está expandido
                              ),
                            ),
                          ),
                        )
                      : const Opacity(opacity: 0.0),
                );
              });
            },
          ),
          backgroundColor: Colors.transparent,
          leading: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            var top = constraints.biggest.height;
            bool isExpanded = top > kToolbarHeight;
            double opacity = isExpanded ? 0.0 : 1.0;
            return AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 300),
              child: Row(
                children: [
                  Expanded(
                    child: leading ??
                        const AppBarBackButton(
                          icon: Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white),
                        ),
                  ),
                ],
              ),
            );
          }),
        );
}

class AppBarBackButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;

  const AppBarBackButton({
    super.key,
    this.icon = const Icon(Icons.arrow_back_rounded),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: AppAppBar.padding,
      onPressed: () => context.go('/'),
      icon: icon,
    );
  }
}

class AppAppBar extends AppBar {
  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 28);

  AppAppBar({
    super.key,
    super.title,
    super.foregroundColor,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTrailingPressed,
  }) : super(
          leading: leading ?? const AppBarBackButton(),
          actions: <Widget>[
            if (trailing != null)
              AppBarBackButton(
                onPressed: onTrailingPressed,
                icon: trailing,
              ),
          ],
        );
}
