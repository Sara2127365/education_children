import 'dart:math';
import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/state/learning_state.dart';
import 'package:education_children/core/state/user_profile_state.dart';
import 'package:education_children/feature/home/home_screen.dart';
import 'package:education_children/feature/island/model/letter_model.dart';
import 'package:flutter/material.dart';

/// الشاشة الرئيسية لتهنئة الطفل بعد إتمام الحرف بنجاح (صفحة أحسنت!)
class LetterSuccessScreen extends StatelessWidget {
  final int letterIndex;

  const LetterSuccessScreen({super.key, required this.letterIndex});

  void _onAwesomePressed(BuildContext context) {
    // 1. تسجيل اكتمال الحرف الحالي
    LearningProgress.completeLetter(letterIndex);

    // 2. التحقق مما إذا كان هذا الحرف هو الأخير (حرف ي / index 27) أو اكتملت جميع الحروف
    final bool isLastLetter = (letterIndex >= arabicLetters.length - 1);
    final bool allDone = isLastLetter ||
        (LearningProgress.completedLetters.value.length >= arabicLetters.length);

    if (allDone) {
      // تعيين جميع الـ 28 حرف كمكتملة
      LearningProgress.completedLetters.value =
          List.generate(arabicLetters.length, (i) => i).toSet();

      // الانتقال مباشرة إلى الصفحة الرئيسية مع تفعيل حالة اكتمال الحروف والانتقال لجزيرة الحركات
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          settings: const RouteSettings(name: '/home_screen'),
          builder: (_) => HomeScreen(
            name: UserProfile.name.value,
            gender: UserProfile.gender.value,
            lettersCompleted: true,
          ),
        ),
        (route) => route.settings.name == '/home_screen' || route.isFirst,
      );
    } else {
      // إذا لم تكتمل كل الحروف، نقوم بتحديد الحرف التالي تلقائياً
      if (letterIndex + 1 < arabicLetters.length) {
        LearningProgress.selectedIndex.value = letterIndex + 1;
      }
      // الرجوع إلى شاشة جزيرة الحروف
      Navigator.of(context).popUntil(
        (route) => route.settings.name == '/letters_island' || route.isFirst,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppLocale.textDirection,
      child: Scaffold(
        backgroundColor: const Color(0xFF040C7B),
        body: Stack(
          children: [
            // خلفية قصاصات الورق الملونة كـ Widget منفصل
            const Positioned.fill(child: ConfettiBackgroundWidget()),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // ويدجت عنوان التهنئة "أحسنت!"
                    SuccessTitleWidget(title: 'well_done'.tr()),

                    const SizedBox(height: 16),

                    // ويدجت النجوم الذهبية الثلاثة
                    const SuccessStarsWidget(),

                    const SizedBox(height: 36),

                    // ويدجت نص المكافأة
                    SuccessRewardTextWidget(text: 'you_earned_coins'.tr()),

                    const SizedBox(height: 28),

                    // ويدجت شارة العملات الذهبية
                    const SuccessCoinsBadgeWidget(coinsAmount: 20),

                    const Spacer(flex: 3),

                    // ويدجت زر المتابعة "رائع"
                    SuccessActionButtonWidget(
                      label: 'awesome'.tr(),
                      onPressed: () => _onAwesomePressed(context),
                    ),

                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// ويدجتس صفحة أحسنت (كل ويدجت منفصل ومنظم في نفس الفايل)
// ============================================================================

/// 1. ويدجت عنوان "أحسنت!" باللون الأصفر والظلال
class SuccessTitleWidget extends StatelessWidget {
  final String? title;

  const SuccessTitleWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? 'well_done'.tr(),
      style: const TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFD400),
        shadows: [
          Shadow(
            color: Colors.black38,
            offset: Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
    );
  }
}

/// 2. ويدجت النجوم الثلاثة الذهبية
class SuccessStarsWidget extends StatelessWidget {
  const SuccessStarsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.star_rounded, size: 52, color: Color(0xFFFFD400)),
        SizedBox(width: 8),
        Icon(Icons.star_rounded, size: 62, color: Color(0xFFFFD400)),
        SizedBox(width: 8),
        Icon(Icons.star_rounded, size: 52, color: Color(0xFFFFD400)),
      ],
    );
  }
}

/// 3. ويدجت نص عدد العملات المكتسبة
class SuccessRewardTextWidget extends StatelessWidget {
  final String text;

  const SuccessRewardTextWidget({
    super.key,
    this.text = 'لقد حصلت علي\n20 عملة ذهبية',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 28,
        height: 1.35,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

/// 4. ويدجت كبسولة العملات الذهبية مع العملات المتساقطة
class SuccessCoinsBadgeWidget extends StatelessWidget {
  final int coinsAmount;

  const SuccessCoinsBadgeWidget({super.key, this.coinsAmount = 20});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // الكبسولة الزرقاء الداكنة
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF13239B),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: const Color(0xFF2A3FB5), width: 2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$coinsAmount',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFD400),
                ),
                child: const Icon(
                  Icons.monetization_on,
                  color: Color(0xFFB8860B),
                  size: 26,
                ),
              ),
            ],
          ),
        ),

        // العملات الذهبية الصغيرة أسفل الكبسولة
        const Positioned(
          bottom: -16,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SuccessMiniCoinWidget(rotationDeg: -8),
              SuccessMiniCoinWidget(rotationDeg: 0),
              SuccessMiniCoinWidget(rotationDeg: 8),
            ],
          ),
        ),
      ],
    );
  }
}

/// 5. ويدجت العملة الذهبية المفردة المائلة
class SuccessMiniCoinWidget extends StatelessWidget {
  final double rotationDeg;

  const SuccessMiniCoinWidget({super.key, required this.rotationDeg});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationDeg * pi / 180,
      child: Container(
        width: 28,
        height: 28,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFFFD400),
          border: Border.all(color: const Color(0xFFE5B800), width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 3,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            '\$',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9E7800),
            ),
          ),
        ),
      ),
    );
  }
}

/// 6. ويدجت زر "رائع" الأزرق التفاعلي
class SuccessActionButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SuccessActionButtonWidget({
    super.key,
    this.label = 'رائع',
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F76F6),
          foregroundColor: Colors.white,
          elevation: 6,
          shadowColor: const Color(0xFF040C7B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// 7. ويدجت خلفية قصاصات الورق الملونة (Confetti)
class ConfettiBackgroundWidget extends StatelessWidget {
  const ConfettiBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _ConfettiPainter());
  }
}

// ============================================================================
// رسام قصاصات الورق الملونة (Confetti Painter)
// ============================================================================

class _ConfettiPainter extends CustomPainter {
  final List<_Particle> _particles = _generateParticles();

  static List<_Particle> _generateParticles() {
    final rand = Random(42);
    final colors = [
      const Color(0xFFFFD400),
      const Color(0xFFE91E63),
      const Color(0xFF00E5FF),
      const Color(0xFFFF9800),
      const Color(0xFF4CAF50),
      const Color(0xFFBA68C8),
      const Color(0xFF29B6F6),
    ];

    return List.generate(45, (i) {
      return _Particle(
        x: rand.nextDouble(),
        y: rand.nextDouble(),
        size: rand.nextDouble() * 10 + 6,
        color: colors[rand.nextInt(colors.length)],
        rotation: rand.nextDouble() * pi,
        isRect: rand.nextBool(),
      );
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _particles) {
      final paint = Paint()..color = p.color;
      canvas.save();
      canvas.translate(p.x * size.width, p.y * size.height);
      canvas.rotate(p.rotation);

      if (p.isRect) {
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: p.size * 1.4,
            height: p.size * 0.7,
          ),
          paint,
        );
      } else {
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size),
          paint,
        );
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Particle {
  final double x;
  final double y;
  final double size;
  final Color color;
  final double rotation;
  final bool isRect;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.rotation,
    required this.isRect,
  });
}
