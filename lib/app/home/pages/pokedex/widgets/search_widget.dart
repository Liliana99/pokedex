import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme.dart';

class CustomSearchWidget extends StatelessWidget {
  final Function(String)? onPressed;

  const CustomSearchWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    TextStyle? hintStyle =
        context.labelM!.copyWith(fontWeight: FontWeight.normal);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0), // Bordos redondeados
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Buscar Pokémon...',
            hintStyle: hintStyle,
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(0),
          ),
          textAlign: TextAlign.center,
          style: hintStyle,
          onSubmitted: (value) => onPressed?.call(value),
        ),
      ),
    );
  }
}
