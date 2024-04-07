import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/assets_constants.dart';
import 'package:o3d/o3d.dart';

class PokeballImage extends StatefulWidget {
  final double maxWidthLogo;
  final Color color;
  const PokeballImage(
      {super.key, required this.maxWidthLogo, required this.color});

  @override
  State<PokeballImage> createState() => _PokeballImageState();
}

class _PokeballImageState extends State<PokeballImage> {
  O3DController controller = O3DController();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: widget.maxWidthLogo,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: widget.color,
            offset: const Offset(0, -6),
            blurRadius: 70,
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: widget.maxWidthLogo, maxHeight: 400),
        child: const O3D.asset(
          ar: false,
          autoRotate: true,
          autoPlay: true,
          src: AssetsImagesConstants.threeDPokeballImage,
        ),
      ),
    );
  }
}
