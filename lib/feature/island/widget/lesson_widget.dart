import 'package:education_children/core/localization/app_locale.dart';
import 'package:flutter/material.dart';

class LessonColors {
  static const background = Color(0xFFDFEEFA);
  static const navy = Color(0xFF0B0A72);
  static const subtitle = Color(0xFF5560B8);
  static const dot = Color(0xFFDDDFF5);
}

/// الدائرة البيضاء الصغيرة (إغلاق / رجوع)
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const CircleIconButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: LessonColors.navy),
      ),
    );
  }
}

/// الهيكل المشترك لكل شاشات الدرس: الهيدر + العنوان الفرعي + المحتوى + الجزء السفلي
class LessonScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? bottom;

  const LessonScaffold({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppLocale.textDirection,
      child: Scaffold(
        backgroundColor: LessonColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    // في RTL أول عنصر يكون على اليمين
                    CircleIconButton(
                      icon: Icons.chevron_left,
                      onTap: () => Navigator.maybePop(context),
                    ),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: LessonColors.navy,
                        ),
                      ),
                    ),
                    CircleIconButton(
                      icon: Icons.close,
                      onTap: () => Navigator.of(context).popUntil((r) => r.isFirst),
                    ),
                  ],
                ),
              ),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 28),
                  child: Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: LessonColors.subtitle,
                    ),
                  ),
                ),
              Expanded(child: child),
              if (bottom != null) bottom!,
            ],
          ),
        ),
      ),
    );
  }
}

/// البطاقة البيضاء الكبيرة بالظل السفلي
class WhiteCard extends StatelessWidget {
  final Widget child;
  const WhiteCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(color: Color(0xFFDDDFF5), offset: Offset(0, 8)),
        ],
      ),
      child: child,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const PrimaryButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: LessonColors.navy,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// الشخصية + الرسالة (قبل: تفكير / بعد: أحسنت + زر متابعة)
class MascotPanel extends StatelessWidget {
  final String mascotAsset;
  final String message;
  final VoidCallback? onContinue;

  const MascotPanel({
    super.key,
    required this.mascotAsset,
    required this.message,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(mascotAsset, height: 230),
          ),
          Positioned(
            right: 20,
            left: 150,
            bottom: 0,
            top: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 28,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                    color: LessonColors.navy,
                  ),
                ),
                if (onContinue != null) ...[
                  const SizedBox(height: 12),
                  PrimaryButton(text: 'continue_btn'.tr(), onTap: onContinue!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}