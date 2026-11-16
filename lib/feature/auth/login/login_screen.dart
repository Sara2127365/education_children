import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/feature/auth/widgets/auth_scaffold.dart';
import 'package:education_children/feature/auth/widgets/labeled_text_field.dart';
import 'package:education_children/feature/auth/widgets/parents_section.dart';
import 'package:education_children/feature/home/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onStart() {
    debugPrint('button pressed');
    final ok = _formKey.currentState!.validate();
    debugPrint('valid: $ok');
    if (ok) {
      Navigator.push(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/home_screen'),
          builder: (_) => HomeScreen(name: _nameController.text.trim()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      formKey: _formKey,
      topSpaceFactor: 0.28,
      buttonText: 'let_us_start'.tr(),
      onButtonPressed: _onStart,
      cardChildren: [
        LabeledTextField(
          label: 'child_name'.tr(),
          hint: 'enter_child_name'.tr(),
          icon: Icons.face_outlined,
          controller: _nameController,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'enter_child_name'.tr() : null,
        ),
        ParentsSection(
          emailController: _emailController,
          phoneController: _phoneController,
        ),
      ],
    );
  }
}
