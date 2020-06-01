import 'package:flutter/material.dart';

class SlideUpAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  SlideUpAnimation({this.child, this.duration});

  @override
  _SlideUpAnimationState createState() => _SlideUpAnimationState();
}

class _SlideUpAnimationState extends State<SlideUpAnimation>
    with TickerProviderStateMixin {
  AnimationController _slideUpController;
  Animation<Offset> _slideUpAnimation;

  @override
  void initState() {
    _slideUpController =
        AnimationController(vsync: this, duration: widget.duration);
    _slideUpAnimation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _slideUpController, curve: Curves.fastLinearToSlowEaseIn));
    super.initState();
    _slideUpController.forward();
  }

  @override
  void dispose() {
    _slideUpController.reverse();
    _slideUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      child: widget.child,
      position: _slideUpAnimation,
    );
  }
}
