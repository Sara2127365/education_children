import 'package:education_children/feature/auth/widgets/auth_scaffold.dart';
import 'package:education_children/feature/auth/widgets/labeled_text_field.dart';
import 'package:education_children/feature/auth/widgets/parents_section.dart';
import 'package:education_children/feature/home/man_teacher.dart';
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
    if (!_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ManTeacher()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      formKey: _formKey,
      topSpaceFactor: 0.28,
      buttonText: 'هيا بنا ، نبدأ',
      onButtonPressed: _onStart,
      cardChildren: [
        LabeledTextField(
          label: 'اسم البطل',
          hint: 'ما اسمك؟',
          icon: Icons.face_outlined,
          controller: _nameController,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'من فضلك اكتب اسمك' : null,
        ),
        ParentsSection(
          emailController: _emailController,
          phoneController: _phoneController,
        ),
      ],
    );
  }
}
