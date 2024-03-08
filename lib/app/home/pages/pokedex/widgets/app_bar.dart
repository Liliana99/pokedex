import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppMovingTitleSliverAppBar extends SliverAppBar {
  static const TextStyle _textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: kToolbarHeight / 8,
      height: 1,
      color: Colors.white);

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
  }) : super(
          expandedHeight: 150,
          floating: false,
          pinned: true,
          snap: false,
          flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            var top = constraints.biggest.height;
            bool isExpanded =
                constraints.biggest.height > (kToolbarHeight + 40);
            double opacity = !isExpanded ? 0.0 : 1.0;
            double searchBarHeight = isExpanded ? kToolbarHeight : 00;
            return FlexibleSpaceBar(
              centerTitle: true,
              title: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: opacity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: kToolbarHeight),
                  child: Text(title,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              background: Padding(
                padding:
                    EdgeInsets.fromLTRB(30, isExpanded ? top * 0.4 : 80, 30, 0),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isExpanded ? 1.0 : 0.0,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          height: searchBarHeight,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: search ?? const SizedBox())),
                ),
              ),
            );
          }),
          backgroundColor: Colors.transparent,
          leading: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            var top = constraints.biggest.height;
            bool isExpanded = top > kToolbarHeight;
            double opacity = isExpanded ? 0.0 : 1.0;
            return AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 300),
              child: Column(
                children: [
                  leading ??
                      const AppBarBackButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white),
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
