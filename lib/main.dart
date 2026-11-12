
import 'package:education_children/feature/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EducationChildren());
}

class EducationChildren extends StatelessWidget {
  const EducationChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,home: SplashScreen());
  }
}
