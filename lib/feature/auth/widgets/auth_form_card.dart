import 'package:education_children/core/style/color_manager.dart';
import 'package:flutter/material.dart';


/// الكارد الأبيض اللي بيحتوي على الحقول (مشترك بين الصفحتين).
/// بيحط مسافة تلقائي بين الـ children.
class AuthFormCard extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const AuthFormCard({super.key, required this.children, this.spacing = 18});

  @override
  Widget build(BuildContext context) {
    final spaced = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i != 0) spaced.add(SizedBox(height: spacing));
      spaced.add(children[i]);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
          decoration: BoxDecoration(
            color: ColorManager.cardBackground.withOpacity(0.96),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Column(children: spaced),
        ),
        // الدايرة الصفراء اللي فوق يمين الكارد
        Positioned(
          top: -22,
          right: -4,
          child: Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: ColorManager.button,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.face, color: ColorManager.textButton),
          ),
        ),
      ],
    );
  }
}