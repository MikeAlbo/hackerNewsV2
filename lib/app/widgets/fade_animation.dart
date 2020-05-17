import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeAnimation({this.child, this.duration});

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with TickerProviderStateMixin {
  AnimationController fadeController;
  Animation<double> fadeAnimation;

  @override
  void initState() {
    fadeController =
        AnimationController(vsync: this, duration: widget.duration);
    super.initState();

    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeIn,
    ));
    fadeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: widget.child,
      opacity: fadeAnimation,
    );
  }

  @override
  void dispose() {
    fadeController.reverse();
    fadeController.dispose();
    super.dispose();
  }
}
