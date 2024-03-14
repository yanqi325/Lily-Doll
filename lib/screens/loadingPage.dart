import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  static const String id = 'loading_page';

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Icon(
            Icons.refresh, // You can replace this with any other loading icon
            size: 50,
            color: Colors.blue, // You can customize the color
          ),
        ),
      ),
    );
  }
}
