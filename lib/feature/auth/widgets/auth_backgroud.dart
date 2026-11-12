import 'package:education_children/core/style/app_assets.dart';
import 'package:flutter/material.dart';


class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(AppAssets.beachBackground, fit: BoxFit.cover),
        child,
      ],
    );
  }
}