import 'package:education_children/core/style/color_manager.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback onPressed;

  // إضافات اختيارية (القيم الافتراضية = شكل الزرار الأصلي بتاعك)
  final double borderRadius;
  final double fontSize;
  final double verticalPadding;
  final Color? shadowColor; // ظل 3D تحت الزرار، لو null مفيش ظل

  const Button({
    super.key,
    required this.text,
    required this.icon,
    this.backgroundColor = ColorManager.button,
    this.textColor = ColorManager.textButton,
    this.borderColor = ColorManager.borderButton,
    this.borderWidth = 1.5,
    required this.onPressed,
    this.borderRadius = 12,
    this.fontSize = 16,
    this.verticalPadding = 12,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: shadowColor == null
              ? null
              : [BoxShadow(color: shadowColor!, offset: const Offset(0, 5))],
        ),
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: textColor),
          label: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: verticalPadding,
            ),
            side: BorderSide(color: borderColor, width: borderWidth),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
      ),
    );
  }
}