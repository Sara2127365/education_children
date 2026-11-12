import 'package:education_children/core/style/color_manager.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'أهلاً بك في أكون!',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: ColorManager.text,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'لنبدأ مغامرة القراءة الممتعة',
          style: TextStyle(fontSize: 17, color: Color(0xFF3B4A57)),
        ),
      ],
    );
  }
}