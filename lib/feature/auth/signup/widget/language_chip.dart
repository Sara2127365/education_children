import 'package:education_children/core/style/color_manager.dart';
import 'package:flutter/material.dart';


class LanguageChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const LanguageChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? ColorManager.skyBlue : const Color(0xFFE6E2D6),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: selected ? ColorManager.skyBlueDark : const Color(0xFFC9C5B8),
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}