
import 'package:education_children/core/style/color_manager.dart';
import 'package:education_children/core/widget/button.dart';
import 'package:education_children/feature/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "أكون .. بالقراءة أكون",
                style: TextStyle(
                  color: ColorManager.text,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Button(
                text: 'ابدأ المغامرة',
                icon: Icons.share,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Onboarding(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
