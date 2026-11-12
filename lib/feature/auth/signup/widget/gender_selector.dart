import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/feature/auth/signup/sign_up_option.dart';
import 'package:education_children/feature/auth/widgets/section_title.dart';
import 'package:flutter/material.dart';

import 'option_card.dart';

class GenderSelector extends StatelessWidget {
  final Gender? selected;
  final ValueChanged<Gender> onChanged;

  const GenderSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'النوع'),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OptionCard(
                label: 'بنت',
                imagePath: AppAssets.girl,
                selected: selected == Gender.girl,
                onTap: () => onChanged(Gender.girl),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OptionCard(
                label: 'ولد',
                imagePath: AppAssets.boy,
                selected: selected == Gender.boy,
                onTap: () => onChanged(Gender.boy),
              ),
            ),
          ],
        ),
      ],
    );
  }
}