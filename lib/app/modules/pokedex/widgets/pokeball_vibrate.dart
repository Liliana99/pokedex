import 'package:flutter/material.dart';

class PokeballVibrate extends StatefulWidget {
  const PokeballVibrate({super.key, this.onTap});
  final void Function()? onTap;

  @override
  State<PokeballVibrate> createState() => _PokeballVibrateState();
}

class _PokeballVibrateState extends State<PokeballVibrate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: widget.onTap?.call,
        child: const Hero(
          tag: "pokeball",
          child: Padding(
            padding: EdgeInsets.only(right: 30),
            child: Icon(Icons.catching_pokemon, color: Colors.red, size: 48),
          ),
        ),
      ),
    );
  }
}
