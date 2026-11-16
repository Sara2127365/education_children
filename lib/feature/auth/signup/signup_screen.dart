import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/state/user_profile_state.dart';
import 'package:education_children/feature/auth/signup/sign_up_option.dart';
import 'package:education_children/feature/auth/signup/widget/dialect_selector.dart';
import 'package:education_children/feature/auth/signup/widget/gender_selector.dart';
import 'package:education_children/feature/auth/signup/widget/guide_selector.dart';
import 'package:education_children/feature/auth/signup/widget/language_selector.dart';
import 'package:education_children/feature/auth/widgets/auth_scaffold.dart';
import 'package:education_children/feature/auth/widgets/labeled_text_field.dart';
import 'package:education_children/feature/auth/widgets/parents_section.dart';
import 'package:education_children/feature/home/man_teacher.dart';
import 'package:education_children/feature/home/woman_teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  Gender? _gender;
  GuideType? _guide;
  late String _language;
  Dialect _dialect = Dialect.gulf;

  @override
  void initState() {
    super.initState();
    _language = AppLocale.languageCode;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (_gender == null || _guide == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('select_gender_and_guide'.tr()),
        ),
      );
      return;
    }

    // حفظ بيانات الطفل واللغة المختارة في UserProfile وتطبيقها فوراً في Core
    UserProfile.update(
      newName: _nameController.text.trim(),
      newGender: _gender,
      newGuide: _guide,
      newAge: int.tryParse(_ageController.text.trim()),
      newDialect: _dialect,
      newLanguage: _language,
    );
    AppLocale.changeLanguage(_language);

    switch (_guide!) {
      case GuideType.female:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WomanTeacher(
              childName: UserProfile.name.value,
              gender: UserProfile.gender.value,
            ),
          ),
        );
        break;

      case GuideType.male:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ManTeacher(
              childName: UserProfile.name.value,
              gender: UserProfile.gender.value,
            ),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      formKey: _formKey,
      topSpaceFactor: 0.1,
      buttonText: 'let_us_start'.tr(),
      onButtonPressed: _onSubmit,
      cardChildren: [
        LabeledTextField(
          label: 'child_name'.tr(),
          hint: 'enter_child_name'.tr(),
          icon: Icons.person_outline,
          controller: _nameController,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'enter_child_name'.tr() : null,
        ),
        LabeledTextField(
          label: 'age'.tr(),
          hint: 'how_old'.tr(),
          icon: Icons.cake_outlined,
          controller: _ageController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'enter_age'.tr() : null,
        ),
        GenderSelector(
          selected: _gender,
          onChanged: (g) => setState(() => _gender = g),
        ),
        GuideSelector(
          selected: _guide,
          onChanged: (g) => setState(() => _guide = g),
        ),
        LanguageSelector(
          selectedCode: _language,
          onChanged: (code) {
            setState(() => _language = code);
            AppLocale.changeLanguage(code);
          },
        ),
        DialectSelector(
          selected: _dialect,
          onChanged: (d) => setState(() => _dialect = d),
        ),
        ParentsSection(
          emailController: _emailController,
          phoneController: _phoneController,
        ),
      ],
    );
  }
}
