import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/assets_constants.dart';
import 'package:o3d/o3d.dart';

class PokeballAnimationCapture extends StatelessWidget {
  const PokeballAnimationCapture({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () => Navigator.of(context).pop(),
      isFullScreen: false,
      disabled: true,
      minRadius: 10,
      maxRadius: 10,
      dragSensitivity: 1.0,
      maxTransformValue: .8,
      direction: DismissiblePageDismissDirection.multi,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        Size size = MediaQuery.of(context).size;
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Container(
                width: size.width,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                      offset: Offset(0, -6),
                      blurRadius: 70,
                    ),
                  ],
                ),
                child: Hero(
                  tag: "pokeball",
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: size.width,
                      maxHeight: size.height * 0.9,
                    ),
                    child: const O3D.asset(
                      ar: false,
                      autoRotate: true,
                      autoPlay: true,
                      src: AssetsImagesConstants.pokeballOpenImage,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
