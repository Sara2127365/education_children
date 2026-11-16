import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/core/style/color_manager.dart';
import 'package:education_children/feature/auth/signup/sign_up_option.dart';
import 'package:education_children/feature/auth/widgets/dashed_divider.dart';
import 'package:flutter/material.dart';

import 'option_card.dart';

class GuideSelector extends StatelessWidget {
  final GuideType? selected;
  final ValueChanged<GuideType> onChanged;

  const GuideSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _GuideHeader(),
        const SizedBox(height: 6),
        Text(
          'choose_guide'.tr(),
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OptionCard(
                label: 'female_teacher'.tr(),
                subLabel: 'female'.tr(),
                labelColor: ColorManager.guidePink,
                imagePath: AppAssets.teacherFemale,
                imageSize: 60,
                selected: selected == GuideType.female,
                onTap: () => onChanged(GuideType.female),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OptionCard(
                label: 'male_teacher'.tr(),
                subLabel: 'male'.tr(),
                labelColor: ColorManager.guideBlue,
                imagePath: AppAssets.teacherMale,
                imageSize: 60,
                selected: selected == GuideType.male,
                onTap: () => onChanged(GuideType.male),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GuideHeader extends StatelessWidget {
  const _GuideHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 13,
          backgroundColor: ColorManager.skyBlue,
          child: Icon(Icons.person, size: 16, color: Colors.white),
        ),
        const SizedBox(width: 6),
        Text(
          'guide_info'.tr(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: ColorManager.text,
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(child: DashedDivider()),
      ],
    );
  }
}
