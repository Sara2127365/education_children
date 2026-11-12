import 'package:education_children/core/style/color_manager.dart';
import 'package:flutter/material.dart';


/// حاوية قابلة للاختيار (بتتلون لما تتحدد) - بتستخدم في النوع والموجه واللهجة.
class SelectableContainer extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final Widget child;
  final Color selectedColor;
  final Color selectedBorderColor;
  final EdgeInsetsGeometry padding;

  const SelectableContainer({
    super.key,
    required this.selected,
    required this.onTap,
    required this.child,
    this.selectedColor = const Color(0xFFE3F4FC),
    this.selectedBorderColor = ColorManager.skyBlue,
    this.padding = const EdgeInsets.all(10),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: padding,
        decoration: BoxDecoration(
          color: selected ? selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? selectedBorderColor : ColorManager.fieldBorder,
            width: selected ? 2.5 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}