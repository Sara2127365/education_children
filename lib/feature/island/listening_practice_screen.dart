import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/state/user_profile_state.dart';
import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/feature/island/letter_success_screen.dart'
    hide TextStyle;
import 'package:education_children/feature/island/model/letter_model.dart';
import 'package:flutter/material.dart' hide TextStyle;
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'widget/lesson_widgets.dart';

class ListeningPracticeScreen extends StatefulWidget {
  final LetterPositionModel letter;
  const ListeningPracticeScreen({super.key, required this.letter});

  @override
  State<ListeningPracticeScreen> createState() =>
      _ListeningPracticeScreenState();
}

class _ListeningPracticeScreenState extends State<ListeningPracticeScreen> {
  late final List<String> _options;
  String? _picked;
  final FlutterTts _tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _tts.setLanguage('ar-SA');
    _tts.setSpeechRate(0.4);

    final others =
        arabicLetters
            .map((e) => e.letter)
            .where((l) => l != widget.letter.letter)
            .toList()
          ..shuffle();
    _options = [widget.letter.letter, others[0], others[1]]..shuffle();

    // نطق الحرف فور فتح الشاشة
    _speakLetter();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _speakLetter() async {
    await _tts.stop();
    await _tts.speak(widget.letter.letter);
  }

  void _onPick(String l) async {
    if (_picked != null && _picked == widget.letter.letter) return;

    setState(() => _picked = l);

    if (l == widget.letter.letter) {
      await _tts.stop();
      await _tts.speak('أحسنت! إجابة صحيحة');
    } else {
      await _tts.stop();
      await _tts.speak('إجابة خاطئة، حاول مرة أخرى');
    }
  }

  void _onRetry() {
    setState(() => _picked = null);
    _speakLetter();
  }

  void _onContinue() {
    final idx = arabicLetters.indexWhere(
      (e) => e.letter == widget.letter.letter,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LetterSuccessScreen(letterIndex: idx != -1 ? idx : 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCorrect = _picked == widget.letter.letter;
    final isWrong = _picked != null && !isCorrect;
    final heroGreeting = UserProfile.isGirl
        ? 'well_done_hero_girl'.tr()
        : 'well_done_hero_boy'.tr();

    return LessonScaffold(
      title: 'listening_practice'.tr(),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  'listen_and_choose'.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A55B8),
                  ),
                ),
                const SizedBox(height: 24),

                // بطاقات الخيارات الثلاثة
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      for (final l in _options)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: _OptionTile(
                              letter: l,
                              state: _stateOf(l),
                              onTap: () => _onPick(l),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // حالة الإجابة الخاطئة (نص ورسالة تكرار)
                if (isWrong) ...[
                  Text(
                    'wrong_answer'.tr(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE52222),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _onRetry,
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.refresh_rounded,
                        color: Color(0xFFE52222),
                        size: 38,
                      ),
                    ),
                  ),
                ],

                // حالة الانتظار قبل الاختيار: زر الاستماع الكبير
                if (_picked == null) ...[
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: _speakLetter,
                    child: Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4A7BFF).withOpacity(.35),
                            blurRadius: 36,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.volume_up_rounded,
                        size: 80,
                        color: Color(0xFF2F4FD8),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 250), // مساحة للشخصية والزر في الأسفل
              ],
            ),
          ),

          // الجزء السفلي عند الإجابة الصحيحة (المعلم + أحسنت أيها البطل + متابعة)
          if (isCorrect)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  height: 220,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // المعلم المبتسم بعلامة الصح
                      Image.asset(
                        AppAssets.teacherCorrect,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 8),
                      // عبارة أحسنت أيها البطل وزر متابعة
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24, right: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                heroGreeting,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 26,
                                  height: 1.25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF070068),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: 150,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: _onContinue,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF070068),
                                    foregroundColor: Colors.white,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  child: Text(
                                    'continue_btn'.tr(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // الجزء السفلي عند الإجابة الخاطئة (المعلم الحزين بعلامة الخطأ)
          if (isWrong)
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                AppAssets.teacherWrong,
                height: 210,
                fit: BoxFit.contain,
              ),
            ),

          // الجزء السفلي في حالة البداية (المعلم المفكر)
          if (_picked == null)
            Positioned(
              left: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Image.asset(AppAssets.teacherThinking, height: 220),
              ),
            ),
        ],
      ),
    );
  }

  _OptionState _stateOf(String l) {
    if (_picked != l) return _OptionState.normal;
    return l == widget.letter.letter
        ? _OptionState.correct
        : _OptionState.wrong;
  }
}

enum _OptionState { normal, correct, wrong }

class _OptionTile extends StatelessWidget {
  final String letter;
  final _OptionState state;
  final VoidCallback onTap;

  const _OptionTile({
    required this.letter,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = switch (state) {
      _OptionState.correct => const Color(0xFF93CFA2),
      _OptionState.wrong => const Color(0xFFEA676F),
      _OptionState.normal => LessonColors.card,
    };

    final border = switch (state) {
      _OptionState.correct => Border.all(
        color: const Color(0xFF388E3C),
        width: 2,
      ),
      _OptionState.wrong => Border.all(
        color: const Color(0xFFD32F2F),
        width: 2,
      ),
      _OptionState.normal => null,
    };

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 108,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: border,
        ),
        child: Text(
          letter,
          style: TextStyle(
            fontSize: 52,
            fontWeight: FontWeight.bold,
            color: state == _OptionState.wrong
                ? Colors.white
                : LessonColors.navy,
          ),
        ),
      ),
    );
  }
}
