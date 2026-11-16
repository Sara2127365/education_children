
import 'package:education_children/core/widget/button.dart';
import 'package:education_children/feature/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAED),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                "أكون ... بالقراءة أكون",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF2670AD),
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Button(
                    text: 'ابدأ المغامرة',
                    icon: Icons.rocket_launch_rounded,
                    backgroundColor: const Color(0xFFFCD400),
                    textColor: const Color(0xFF382600),
                    borderColor: Colors.transparent,
                    shadowColor: const Color(0xFF705D00),
                    borderRadius: 36,
                    fontSize: 22,
                    verticalPadding: 16,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Onboarding(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
