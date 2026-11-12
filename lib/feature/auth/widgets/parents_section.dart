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
        const SectionTitle(
          title: 'قسم الوالدين',
          icon: Icons.supervisor_account,
          color: Colors.black87,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: emailController,
          hint: 'البريد الإلكتروني',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'اكتب البريد الإلكتروني';
            if (!v.contains('@')) return 'البريد غير صحيح';
            return null;
          },
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: phoneController,
          hint: 'رقم الهاتف',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (v) =>
              (v == null || v.trim().length < 10) ? 'رقم الهاتف غير صحيح' : null,
        ),
      ],
    );
  }
}