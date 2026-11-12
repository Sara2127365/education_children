import 'package:education_children/core/style/color_manager.dart';
import 'package:education_children/feature/auth/widgets/selectable_container.dart';
import 'package:flutter/material.dart';


class DialectCard extends StatelessWidget {
  final String label;
  final String imagePath;
  final bool selected;
  final VoidCallback onTap;

  const DialectCard({
    super.key,
    required this.label,
    required this.imagePath,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableContainer(
      selected: selected,
      onTap: onTap,
      selectedColor: ColorManager.selectedGreen,
      selectedBorderColor: ColorManager.selectedGreenBorder,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFEFEADB),
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}