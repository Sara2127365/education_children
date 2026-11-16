import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/state/user_profile_state.dart';
import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/feature/island/widget/lesson_widget.dart';
import 'package:flutter/material.dart';

/// شاشة "اكتب" - تتبع الحرف بالنقاط
class WriteLetterScreen extends StatefulWidget {
  final String letterName;
  final String letterChar;
  final VoidCallback onContinue;

  const WriteLetterScreen({
    super.key,
    this.letterName = 'ب',
    this.letterChar = 'ب',
    required this.onContinue,
  });

  @override
  State<WriteLetterScreen> createState() => _WriteLetterScreenState();
}

class _WriteLetterScreenState extends State<WriteLetterScreen> {
  late final List<Offset> _dots;
  final List<List<Offset>> _strokes = [];
  final Set<int> _hit = {};
  Size _size = Size.zero;

  @override
  void initState() {
    super.initState();
    _dots = _getDotsForLetter(widget.letterChar);
  }

  bool get _done => _hit.length >= _dots.length;

  void _clear() {
    setState(() {
      _strokes.clear();
      _hit.clear();
    });
  }

  void _checkHits(Offset p) {
    for (int i = 0; i < _dots.length; i++) {
      final center =
          Offset(_dots[i].dx * _size.width, _dots[i].dy * _size.height);
      if ((center - p).distance < 28) _hit.add(i);
    }
  }

  void _start(Offset p) {
    if (_done) return;
    setState(() {
      _strokes.add([p]);
      _checkHits(p);
    });
  }

  void _update(Offset p) {
    if (_done) return;
    setState(() {
      if (_strokes.isNotEmpty) _strokes.last.add(p);
      _checkHits(p);
    });
  }

  static List<Offset> _getDotsForLetter(String letter) {
    final l = letter.trim();
    if (l == 'أ' || l == 'ا' || l == 'إ' || l == 'آ') {
      return const [
        // عصا الألف
        Offset(.500, .320),
        Offset(.500, .420),
        Offset(.500, .520),
        Offset(.500, .620),
        Offset(.500, .720),
        Offset(.500, .800),
        // الهمزة
        Offset(.460, .190),
        Offset(.520, .160),
        Offset(.550, .210),
        Offset(.480, .240),
      ];
    } else if (l == 'ت') {
      return const [
        // صحن التاء
        Offset(.210, .420),
        Offset(.230, .540),
        Offset(.290, .640),
        Offset(.390, .700),
        Offset(.500, .710),
        Offset(.610, .700),
        Offset(.710, .640),
        Offset(.770, .540),
        Offset(.790, .420),
        // نقطتان فوق
        Offset(.450, .480),
        Offset(.550, .480),
      ];
    } else if (l == 'ث') {
      return const [
        // صحن الثاء
        Offset(.210, .420),
        Offset(.230, .540),
        Offset(.290, .640),
        Offset(.390, .700),
        Offset(.500, .710),
        Offset(.610, .700),
        Offset(.710, .640),
        Offset(.770, .540),
        Offset(.790, .420),
        // ثلاث نقاط فوق
        Offset(.500, .400),
        Offset(.440, .480),
        Offset(.560, .480),
      ];
    } else if (l == 'ح') {
      return const [
        // رأس الحاء
        Offset(.350, .280),
        Offset(.480, .260),
        Offset(.620, .280),
        // بطن الحاء
        Offset(.540, .380),
        Offset(.680, .500),
        Offset(.680, .650),
        Offset(.560, .770),
        Offset(.400, .800),
        Offset(.280, .700),
      ];
    } else if (l == 'ج') {
      return const [
        // رأس الجيم
        Offset(.350, .280),
        Offset(.480, .260),
        Offset(.620, .280),
        // بطن الجيم
        Offset(.540, .380),
        Offset(.680, .500),
        Offset(.680, .650),
        Offset(.560, .770),
        Offset(.400, .800),
        Offset(.280, .700),
        // نقطة في البطن
        Offset(.480, .550),
      ];
    } else if (l == 'خ') {
      return const [
        // رأس الخاء
        Offset(.350, .280),
        Offset(.480, .260),
        Offset(.620, .280),
        // بطن الخاء
        Offset(.540, .380),
        Offset(.680, .500),
        Offset(.680, .650),
        Offset(.560, .770),
        Offset(.400, .800),
        Offset(.280, .700),
        // نقطة فوق الرأس
        Offset(.500, .160),
      ];
    } else if (l == 'د') {
      return const [
        Offset(.620, .360),
        Offset(.560, .470),
        Offset(.480, .580),
        Offset(.400, .680),
        Offset(.530, .700),
        Offset(.660, .700),
      ];
    } else if (l == 'ذ') {
      return const [
        Offset(.620, .360),
        Offset(.560, .470),
        Offset(.480, .580),
        Offset(.400, .680),
        Offset(.530, .700),
        Offset(.660, .700),
        // نقطة فوق
        Offset(.540, .230),
      ];
    } else if (l == 'ر') {
      return const [
        Offset(.580, .360),
        Offset(.550, .470),
        Offset(.480, .580),
        Offset(.380, .700),
        Offset(.280, .780),
      ];
    } else if (l == 'ز') {
      return const [
        Offset(.580, .360),
        Offset(.550, .470),
        Offset(.480, .580),
        Offset(.380, .700),
        Offset(.280, .780),
        // نقطة فوق
        Offset(.580, .240),
      ];
    } else if (l == 'س') {
      return const [
        // أسنان السين
        Offset(.720, .440),
        Offset(.660, .540),
        Offset(.600, .440),
        Offset(.540, .540),
        Offset(.480, .440),
        Offset(.420, .540),
        // صحن السين
        Offset(.340, .660),
        Offset(.250, .750),
        Offset(.170, .690),
        Offset(.160, .570),
      ];
    } else if (l == 'ش') {
      return const [
        // أسنان الشين
        Offset(.720, .440),
        Offset(.660, .540),
        Offset(.600, .440),
        Offset(.540, .540),
        Offset(.480, .440),
        Offset(.420, .540),
        // صحن الشين
        Offset(.340, .660),
        Offset(.250, .750),
        Offset(.170, .690),
        Offset(.160, .570),
        // 3 نقاط
        Offset(.600, .280),
        Offset(.540, .360),
        Offset(.660, .360),
      ];
    } else if (l == 'ص') {
      return const [
        // حلقة الصاد
        Offset(.440, .560),
        Offset(.540, .460),
        Offset(.680, .460),
        Offset(.740, .560),
        Offset(.600, .580),
        Offset(.440, .580),
        // صحن الصاد
        Offset(.340, .680),
        Offset(.240, .760),
        Offset(.160, .680),
        Offset(.140, .560),
      ];
    } else if (l == 'ض') {
      return const [
        // حلقة الضاد
        Offset(.440, .560),
        Offset(.540, .460),
        Offset(.680, .460),
        Offset(.740, .560),
        Offset(.600, .580),
        Offset(.440, .580),
        // صحن الضاد
        Offset(.340, .680),
        Offset(.240, .760),
        Offset(.160, .680),
        Offset(.140, .560),
        // نقطة فوق
        Offset(.600, .340),
      ];
    } else if (l == 'ط') {
      return const [
        // قاعدة الطاء
        Offset(.350, .650),
        Offset(.500, .520),
        Offset(.680, .520),
        Offset(.750, .650),
        Offset(.500, .660),
        Offset(.300, .660),
        // عصا الطاء
        Offset(.450, .220),
        Offset(.450, .360),
        Offset(.450, .500),
      ];
    } else if (l == 'ظ') {
      return const [
        // قاعدة الظاء
        Offset(.350, .650),
        Offset(.500, .520),
        Offset(.680, .520),
        Offset(.750, .650),
        Offset(.500, .660),
        Offset(.300, .660),
        // عصا الظاء
        Offset(.450, .220),
        Offset(.450, .360),
        Offset(.450, .500),
        // نقطة
        Offset(.580, .280),
      ];
    } else if (l == 'ع') {
      return const [
        // عين صغيرة
        Offset(.600, .300),
        Offset(.500, .240),
        Offset(.400, .320),
        Offset(.480, .420),
        // بطن كبير
        Offset(.620, .520),
        Offset(.660, .680),
        Offset(.540, .800),
        Offset(.360, .820),
        Offset(.240, .720),
      ];
    } else if (l == 'غ') {
      return const [
        // عين صغيرة
        Offset(.600, .300),
        Offset(.500, .240),
        Offset(.400, .320),
        Offset(.480, .420),
        // بطن كبير
        Offset(.620, .520),
        Offset(.660, .680),
        Offset(.540, .800),
        Offset(.360, .820),
        Offset(.240, .720),
        // نقطة فوق
        Offset(.500, .140),
      ];
    } else if (l == 'ف') {
      return const [
        // رأس الفاء
        Offset(.620, .440),
        Offset(.680, .360),
        Offset(.600, .320),
        Offset(.540, .400),
        Offset(.600, .460),
        // صحن الفاء
        Offset(.500, .600),
        Offset(.400, .660),
        Offset(.300, .640),
        Offset(.220, .540),
        // نقطة فوق
        Offset(.620, .220),
      ];
    } else if (l == 'ق') {
      return const [
        // رأس القاف
        Offset(.620, .380),
        Offset(.680, .300),
        Offset(.600, .260),
        Offset(.540, .340),
        Offset(.600, .400),
        // صحن القاف
        Offset(.520, .560),
        Offset(.420, .700),
        Offset(.300, .740),
        Offset(.220, .620),
        Offset(.200, .500),
        // نقطتان فوق
        Offset(.550, .160),
        Offset(.670, .160),
      ];
    } else if (l == 'ك') {
      return const [
        Offset(.680, .240),
        Offset(.680, .420),
        Offset(.680, .600),
        Offset(.580, .680),
        Offset(.420, .680),
        Offset(.300, .620),
        Offset(.260, .520),
        // همزة الكاف
        Offset(.480, .440),
        Offset(.540, .480),
        Offset(.480, .540),
      ];
    } else if (l == 'ل') {
      return const [
        Offset(.620, .220),
        Offset(.620, .400),
        Offset(.620, .580),
        Offset(.560, .720),
        Offset(.420, .780),
        Offset(.300, .720),
        Offset(.240, .580),
      ];
    } else if (l == 'م') {
      return const [
        // رأس الميم
        Offset(.560, .420),
        Offset(.640, .360),
        Offset(.580, .300),
        Offset(.500, .360),
        Offset(.540, .440),
        // ساق الميم
        Offset(.460, .480),
        Offset(.400, .600),
        Offset(.380, .740),
        Offset(.360, .860),
      ];
    } else if (l == 'ن') {
      return const [
        Offset(.740, .440),
        Offset(.700, .580),
        Offset(.580, .720),
        Offset(.420, .740),
        Offset(.300, .640),
        Offset(.260, .480),
        // نقطة بالوسط
        Offset(.500, .480),
      ];
    } else if (l == 'ه') {
      return const [
        Offset(.680, .560),
        Offset(.600, .420),
        Offset(.480, .380),
        Offset(.380, .480),
        Offset(.420, .600),
        Offset(.540, .600),
        Offset(.580, .500),
        Offset(.500, .500),
        Offset(.320, .600),
      ];
    } else if (l == 'و') {
      return const [
        // رأس الواو
        Offset(.580, .400),
        Offset(.660, .340),
        Offset(.600, .260),
        Offset(.500, .320),
        Offset(.540, .420),
        // ساق الواو
        Offset(.480, .540),
        Offset(.400, .660),
        Offset(.300, .760),
      ];
    } else if (l == 'ي') {
      return const [
        Offset(.640, .340),
        Offset(.540, .320),
        Offset(.460, .400),
        Offset(.520, .500),
        Offset(.600, .600),
        Offset(.540, .720),
        Offset(.400, .760),
        Offset(.280, .700),
        Offset(.240, .580),
        // نقطتان تحت
        Offset(.420, .850),
        Offset(.520, .850),
      ];
    } else {
      // الباء ومشتقاتها (الافتراضي)
      return const [
        Offset(.206, .391),
        Offset(.214, .483),
        Offset(.249, .571),
        Offset(.314, .637),
        Offset(.403, .671),
        Offset(.500, .683),
        Offset(.591, .671),
        Offset(.683, .637),
        Offset(.749, .571),
        Offset(.783, .483),
        Offset(.794, .391),
        Offset(.500, .829),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final heroGreeting = UserProfile.isGirl
        ? 'well_done_hero_girl'.tr()
        : 'well_done_hero_boy'.tr();

    return LessonScaffold(
      title: 'write_letter'.tr(),
      subtitle: _done ? null : 'تتبع حرف ${widget.letterChar} بالنقاط',
      bottom: _done
          ? MascotPanel(
              mascotAsset: AppAssets.manTeacher,
              message: heroGreeting,
              onContinue: widget.onContinue,
            )
          : MascotPanel(
              mascotAsset: AppAssets.teacherThinking,
              message: 'قم بتتبع النقاط لكتابة\nحرف ${widget.letterChar}',
            ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 24, 22, 0),
        child: AspectRatio(
          aspectRatio: 1,
          child: WhiteCard(
            child: LayoutBuilder(
              builder: (context, c) {
                _size = Size(c.maxWidth, c.maxHeight);
                return Stack(
                  children: [
                    // مساحة الرسم وتوصيل النقاط
                    Positioned.fill(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onPanStart: (d) => _start(d.localPosition),
                        onPanUpdate: (d) => _update(d.localPosition),
                        onTapDown: (d) => _start(d.localPosition),
                        child: Stack(
                          children: [
                            // رسم الحرف الفعلي كعلامة مائية خفيفة خلف النقاط لتوجيه الطفل
                            Center(
                              child: Text(
                                widget.letterChar,
                                style: TextStyle(
                                  fontSize: 160,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFD6E3F4).withOpacity(0.7),
                                ),
                              ),
                            ),
                            // النقاط والخطوط التفاعلية
                            CustomPaint(
                              size: _size,
                              painter: _TracePainter(
                                dots: _dots,
                                hit: _hit,
                                strokes: _strokes,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // زر المسح (Clear) لإعادة الرسم والمسح
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: _clear,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _strokes.isEmpty
                                ? const Color(0xFFF1F5F9)
                                : const Color(0xFFFFEDEC),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _strokes.isEmpty
                                  ? const Color(0xFFCBD5E1)
                                  : const Color(0xFFFCA5A5),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.refresh_rounded,
                                size: 18,
                                color: _strokes.isEmpty
                                    ? const Color(0xFF64748B)
                                    : const Color(0xFFDC2626),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'clear'.tr(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _strokes.isEmpty
                                      ? const Color(0xFF64748B)
                                      : const Color(0xFFDC2626),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _TracePainter extends CustomPainter {
  final List<Offset> dots;
  final Set<int> hit;
  final List<List<Offset>> strokes;

  _TracePainter({required this.dots, required this.hit, required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()..color = LessonColors.dot;
    final hitPaint = Paint()..color = const Color(0xFF55B85D);

    for (int i = 0; i < dots.length; i++) {
      final center = Offset(dots[i].dx * size.width, dots[i].dy * size.height);
      final isHit = hit.contains(i);
      canvas.drawCircle(center, 12, isHit ? hitPaint : dotPaint);
    }

    final linePaint = Paint()
      ..color = const Color(0xFF1E3A8A)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (final s in strokes) {
      if (s.length == 1) {
        canvas.drawCircle(s.first, 3, Paint()..color = const Color(0xFF1E3A8A));
        continue;
      }
      final path = Path()..moveTo(s.first.dx, s.first.dy);
      for (final p in s.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(path, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TracePainter old) => true;
}
