import 'package:education_children/feature/auth/signup/sign_up_option.dart';
import 'package:education_children/feature/auth/widgets/section_title.dart';
import 'package:flutter/material.dart';

import 'language_chip.dart';

class LanguageSelector extends StatelessWidget {
  final String selectedCode;
  final ValueChanged<String> onChanged;

  const LanguageSelector({
    super.key,
    required this.selectedCode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'اختر لغتك'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 14,
          children: [
            for (final lang in languageOptions)
              LanguageChip(
                label: lang.label,
                selected: lang.code == selectedCode,
                onTap: () => onChanged(lang.code),
              ),
          ],
        ),
      ],
    );
  }
}