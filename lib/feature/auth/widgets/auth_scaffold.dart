import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/core/style/color_manager.dart';
import 'package:education_children/core/widget/button.dart';
import 'package:education_children/feature/auth/widgets/auth_backgroud.dart';
import 'package:flutter/material.dart';

import 'auth_form_card.dart';
import 'auth_header.dart';


/// هيكل الصفحتين: خلفية + عنوان + كارد + زرار.
/// كل صفحة بتبعت بس محتوى الكارد.
class AuthScaffold extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<Widget> cardChildren;
  final String buttonText;
  final VoidCallback onButtonPressed;

  /// نسبة المسافة اللي فوق من ارتفاع الشاشة (الصفحات الطويلة تحتاج أقل).
  final double topSpaceFactor;

  const AuthScaffold({
    super.key,
    required this.formKey,
    required this.cardChildren,
    required this.buttonText,
    required this.onButtonPressed,
    this.topSpaceFactor = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: AuthBackground(
          imagePath: AppAssets.beachBackground,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height:
                          MediaQuery.of(context).size.height * topSpaceFactor,
                    ),
                    const AuthHeader(),
                    const SizedBox(height: 36),
                    AuthFormCard(children: cardChildren),
                    const SizedBox(height: 24),
                    Button(
                      text: buttonText,
                      icon: Icons.rocket_launch_outlined,
                      onPressed: onButtonPressed,
                      borderRadius: 32,
                      fontSize: 22,
                      verticalPadding: 14,
                      shadowColor: ColorManager.borderButton,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}