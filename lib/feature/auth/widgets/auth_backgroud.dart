
import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  final String imagePath;

  const AuthBackground({
    super.key,
    required this.child,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  }
}
