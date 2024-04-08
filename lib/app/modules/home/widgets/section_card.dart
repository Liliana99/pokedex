import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final Color color;

  final bool isLightColor;
  final VoidCallback? onPressed;

  const SectionCard({
    super.key,
    required this.title,
    required this.color,
    this.isLightColor = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final height = constraints.maxHeight;
      final borderRadius = BorderRadius.circular(20);

      return Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: _CardShadow(color: color),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: color,
              foregroundColor: color,
              surfaceTintColor: color,
              disabledBackgroundColor: color,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: _CircleDecorator(
                      size: height,
                      isLightColor: isLightColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _PokeballDecorator(
                      size: height,
                      isLightColor: isLightColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      title,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      textScaler: const TextScaler.linear(0.9),
                      style: context.titleM!.copyWith(
                          color: isLightColor
                              ? Colors.black.withOpacity(0.7)
                              : Colors.white.withOpacity(0.8),
                          fontWeight:
                              isLightColor ? FontWeight.bold : FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _CardShadow extends StatelessWidget {
  const _CardShadow({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 11,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: color,
            offset: const Offset(0, 6),
            blurRadius: 23,
          ),
        ],
      ),
    );
  }
}

class _CircleDecorator extends StatelessWidget {
  final double size;
  final bool isLightColor;

  const _CircleDecorator({required this.size, required this.isLightColor});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-size * 0.5, -size * 0.9),
      child: CircleAvatar(
        radius: 10,
        backgroundColor:
            isLightColor ? Colors.white : Colors.white.withOpacity(0.14),
      ),
    );
  }
}

class _PokeballDecorator extends StatelessWidget {
  final double size;
  final bool isLightColor;

  const _PokeballDecorator({required this.size, required this.isLightColor});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.0,
      alignment: Alignment.topRight,
      child: Image.asset(
        'assets/images/pokeball.png',
        width: size,
        height: size,
        color: isLightColor
            ? Colors.white.withOpacity(0.3)
            : Colors.white.withOpacity(0.14),
        fit: BoxFit.contain,
      ),
    );
  }
}
