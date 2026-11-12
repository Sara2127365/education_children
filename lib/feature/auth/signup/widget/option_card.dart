import 'package:education_children/feature/auth/widgets/selectable_container.dart';
import 'package:flutter/material.dart';


/// كارد أفقي: نص + صورة (بيستخدم في النوع والموجه).
class OptionCard extends StatelessWidget {
  final String label;
  final String? subLabel;
  final Color labelColor;
  final String imagePath;
  final double imageSize;
  final bool selected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.label,
    required this.imagePath,
    required this.selected,
    required this.onTap,
    this.subLabel,
    this.labelColor = Colors.black87,
    this.imageSize = 44,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableContainer(
      selected: selected,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: labelColor,
                ),
              ),
              if (subLabel != null)
                Text(
                  subLabel!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
            ],
          ),
          const SizedBox(width: 8),
          Image.asset(imagePath, width: imageSize, height: imageSize),
        ],
      ),
    );
  }
}