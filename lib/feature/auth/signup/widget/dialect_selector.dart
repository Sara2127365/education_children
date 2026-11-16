import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/feature/auth/signup/sign_up_option.dart';
import 'package:education_children/feature/auth/widgets/section_title.dart';
import 'package:flutter/material.dart';

import 'dialect_card.dart';

class DialectSelector extends StatelessWidget {
  final Dialect selected;
  final ValueChanged<Dialect> onChanged;

  const DialectSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      (Dialect.gulf, 'dialect_gulf'.tr(), AppAssets.dialectGulf),
      (Dialect.egyptian, 'dialect_egyptian'.tr(), AppAssets.dialectEgyptian),
      (Dialect.fusha, 'dialect_fusha'.tr(), AppAssets.dialectFusha),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'choose_dialect'.tr()),
        const SizedBox(height: 12),
        Row(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i != 0) const SizedBox(width: 10),
              Expanded(
                child: DialectCard(
                  label: items[i].$2,
                  imagePath: items[i].$3,
                  selected: selected == items[i].$1,
                  onTap: () => onChanged(items[i].$1),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
