import 'package:education_children/core/style/color_manager.dart';
import 'package:flutter/material.dart';


class SectionTitle extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color color;

  const SectionTitle({
    super.key,
    required this.title,
    this.icon,
    this.color = ColorManager.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 22, color: ColorManager.textButton),
          const SizedBox(width: 6),
        ],
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}