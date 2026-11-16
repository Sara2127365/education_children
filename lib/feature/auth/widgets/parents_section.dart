import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/feature/auth/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import 'dashed_divider.dart';
import 'section_title.dart';

/// قسم الوالدين (خط منقط + إيميل + رقم هاتف) - مشترك بين الصفحتين.
class ParentsSection extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const ParentsSection({
    super.key,
    required this.emailController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DashedDivider(),
        const SizedBox(height: 16),
        SectionTitle(
          title: 'parents_section'.tr(),
          icon: Icons.supervisor_account,
          color: Colors.black87,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: emailController,
          hint: 'email'.tr(),
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'enter_email'.tr();
            if (!v.contains('@')) return 'invalid_email'.tr();
            return null;
          },
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: phoneController,
          hint: 'phone'.tr(),
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (v) =>
              (v == null || v.trim().length < 10) ? 'invalid_phone'.tr() : null,
        ),
      ],
    );
  }
}
