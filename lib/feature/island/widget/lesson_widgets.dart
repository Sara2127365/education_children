import 'package:flutter/material.dart';

class LessonColors {
  static const bg = Color(0xFFE1EEF9);
  static const navy = Color(0xFF0B0B6B);
  static const card = Color(0xFFF8F9FC);
  static const yellow = Color(0xFFF5D800);
  static const green = Color(0xFF55B85D);
}

/// Shared page: light-blue background, top bar (close + title + back), bottom button.
class LessonScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool showBack;

  const LessonScaffold({
    super.key,
    required this.title,
    required this.child,
    this.buttonText,
    this.onButtonPressed,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: LessonColors.bg,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  children: [
                    // First child = right side in RTL
                    showBack
                        ? _RoundIconButton(
                            icon: Icons.arrow_back_ios_new_rounded,
                            onTap: () => Navigator.maybePop(context),
                          )
                        : const SizedBox(width: 32),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: LessonColors.navy,
                        ),
                      ),
                    ),
                    _RoundIconButton(
                      icon: Icons.close_rounded,
                      // Back to the first route (change if your home isn't the first route)
                      onTap: () =>
                          Navigator.of(context).popUntil((r) => r.isFirst),
                    ),
                  ],
                ),
              ),
              Expanded(child: child),
              if (buttonText != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: LessonButton(
                    text: buttonText!,
                    onPressed: onButtonPressed,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundIconButton({required this.icon, required this.onTap});

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
        child: Icon(icon, size: 15, color: LessonColors.navy),
      ),
    );
  }
}

class LessonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const LessonButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: LessonColors.navy,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

/// Square card with a big letter (used in learn / speaking screens).
class LetterCard extends StatelessWidget {
  final String letter;
  final double width;
  final double height;
  const LetterCard({
    super.key,
    required this.letter,
    this.width = 210,
    this.height = 168,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: LessonColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: LessonColors.yellow, width: 1.5),
      ),
      child: Text(
        letter,
        style: const TextStyle(
          fontSize: 110,
          height: 1.1,
          fontWeight: FontWeight.w600,
          color: LessonColors.navy,
        ),
      ),
    );
  }
}

/// Light-blue circle with a speaker icon.
class SpeakerButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double size;
  final bool outlined;
  const SpeakerButton({
    super.key,
    this.onTap,
    this.size = 54,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: outlined ? LessonColors.card : const Color(0xFFD6E6FA),
          border: outlined
              ? Border.all(color: LessonColors.yellow, width: 2)
              : null,
        ),
        child: Icon(
          Icons.volume_up_rounded,
          size: size * 0.55,
          color: const Color(0xFF2F4FD8),
        ),
      ),
    );
  }
}