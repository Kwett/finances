import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xFF71A7F1), Color(0xFFB9CFEC)],
            ),
          ),
        ),

        Positioned.fill(
          child: Image.asset(
            'assets/Ellipse.png',
            fit: BoxFit.fitWidth,
          ),
        ),

        child,
      ],
    );
  }
}
