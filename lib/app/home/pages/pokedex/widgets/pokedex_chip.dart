import 'package:flutter/material.dart';

class PokedexChip extends StatelessWidget {
  const PokedexChip({
    super.key,
    required this.name,
    this.color,
  });
  final String name;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Align(
        alignment: Alignment.topLeft,
        child: Chip(
          label: Text(
            name,
            textAlign: TextAlign.left,
            maxLines: 2,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Colors.white, fontWeight: FontWeight.w300, fontSize: 10),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.transparent),
          ),
          color: MaterialStatePropertyAll(color!),
        ),
      ),
    );
  }
}
