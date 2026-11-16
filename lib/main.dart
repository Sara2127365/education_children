import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/feature/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EducationChildren());
}

class EducationChildren extends StatelessWidget {
  const EducationChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: AppLocale.currentLocale,
      builder: (context, langCode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Locale(langCode),
          builder: (context, child) {
            return Directionality(
              textDirection: AppLocale.textDirection,
              child: child ?? const SizedBox.shrink(),
            );
          },
          home: const SplashScreen(),
        );
      },
    );
  }
}
