import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/feature/auth/widgets/auth_backgroud.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AuthBackground(child: Column(), imagePath: AppAssets.backgroundHome),);
  }
}