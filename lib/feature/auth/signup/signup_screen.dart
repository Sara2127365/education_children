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
  String _language = 'ar';
  Dialect _dialect = Dialect.gulf;

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
      const SnackBar(
        content: Text('من فضلك اختر النوع والموجه'),
      ),
    );
    return;
  }

  switch (_guide!) {
    case GuideType.female:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WomanTeacher(),
        ),
      );
      break;

    case GuideType.male:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ManTeacher(),
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
      buttonText: 'هيا بنا ، نبدأ',
      onButtonPressed: _onSubmit,
      cardChildren: [
        LabeledTextField(
          label: 'اسم الطفل',
          hint: 'اكتب اسم الطفل',
          icon: Icons.person_outline,
          controller: _nameController,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'اكتب اسم الطفل' : null,
        ),
        LabeledTextField(
          label: 'العمر',
          hint: 'كم عمرك؟',
          icon: Icons.cake_outlined,
          controller: _ageController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (v) => (v == null || v.trim().isEmpty) ? 'اكتب العمر' : null,
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
          onChanged: (code) => setState(() => _language = code),
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