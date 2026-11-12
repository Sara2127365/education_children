
import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/core/style/color_manager.dart';
import 'package:education_children/feature/auth/login/login_screen.dart';
import 'package:education_children/feature/auth/signup/signup_screen.dart';
import 'package:education_children/feature/onboarding/widget/button_onboarding.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorManager.backgroundOnboarding,
      body: Align(
        alignment: Alignment(0, 0.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonOnboarding(
              text: "انشاء حساب",
              backgroundColor: ColorManager.buttonSignUp,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            ButtonOnboarding(
              text: 'تسجيل الدخول',
              backgroundColor: ColorManager.buttonLogin,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Image.asset(AppAssets.onboarding),
          ],
        ),
      ),
    );
  }
}
