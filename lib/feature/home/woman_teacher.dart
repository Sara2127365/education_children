import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/core/widget/button.dart';
import 'package:education_children/feature/auth/widgets/auth_backgroud.dart';
import 'package:education_children/feature/home/home_screen.dart';
import 'package:flutter/material.dart';

class WomanTeacher extends StatelessWidget {
  const WomanTeacher({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'مرحبا بك في أكون! سأكون معلمك ومساعدك في رحلتك للتعلم وتصبح بطلاً في القراءة',
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
                  text: 'التالي',
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen(name: '',)),
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
