import 'package:flutter/material.dart';

class GradientBackgroundWidget extends StatelessWidget {
  final Widget child;
  const GradientBackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0F052C),
                Colors.black,
                Colors.black,
                Colors.black,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.6, 0.9],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: child,
        ),
      ],
    );
  }
}
