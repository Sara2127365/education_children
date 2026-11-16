import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/state/user_profile_state.dart';
import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/core/widget/button.dart';
import 'package:education_children/feature/auth/signup/sign_up_option.dart';
import 'package:education_children/feature/auth/widgets/auth_backgroud.dart';
import 'package:education_children/feature/home/home_screen.dart';
import 'package:flutter/material.dart';

class WomanTeacher extends StatelessWidget {
  final String childName;
  final Gender gender;

  const WomanTeacher({
    super.key,
    this.childName = 'عمر',
    this.gender = Gender.boy,
  });

  @override
  Widget build(BuildContext context) {
    final isGirl = (gender == Gender.girl) || UserProfile.isGirl;
    final greeting =
        isGirl ? 'teacher_greeting_girl'.tr() : 'teacher_greeting_boy'.tr();

    return Scaffold(
      body: AuthBackground(
        imagePath: AppAssets.backgroudTeacher,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  greeting,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Image.asset(
                  AppAssets.womanTeacher,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.contain,
                ),
                Button(
                  text: 'next'.tr(),
                  icon: AppLocale.isRtl
                      ? Icons.arrow_back
                      : Icons.arrow_forward,
                  onPressed: () {
                    final resolvedName = childName.trim().isNotEmpty
                        ? childName.trim()
                        : (UserProfile.name.value.isNotEmpty
                            ? UserProfile.name.value
                            : (isGirl ? 'سارة' : 'عمر'));

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        settings: const RouteSettings(name: '/home_screen'),
                        builder: (context) => HomeScreen(
                          name: resolvedName,
                          gender: isGirl ? Gender.girl : Gender.boy,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
