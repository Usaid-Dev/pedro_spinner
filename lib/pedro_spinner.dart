import 'dart:math';
import 'package:flutter/material.dart';

class PedroSpinner extends StatefulWidget {
  const PedroSpinner({super.key});

  @override
  State<PedroSpinner> createState() => _PedroSpinnerState();
}

class _PedroSpinnerState extends State<PedroSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Slower rotation speed
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
              angle: _controller.value * 2 * pi,
              child: Center(
                child: DanceTransition(
                  controller: _controller,
                  child: Image.asset(
                    'images/pedro.png', // Replace with your image path
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DanceTransition extends AnimatedWidget {
  const DanceTransition({
    super.key,
    required Animation<double> controller,
    required this.child,
  }) : super(listenable: controller);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final zoomAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 2.0), // Zoom in
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 2.0, end: 1.0), // Zoom out
        weight: 1,
      ),
    ]).animate(animation);

    return Transform.scale(
      scale: zoomAnimation.value,
      child: child,
    );
  }
}
