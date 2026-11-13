import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/feature/letters/model/letter_model.dart';
import 'package:flutter/material.dart';
import 'lesson_widgets.dart';


class ListeningPracticeScreen extends StatefulWidget {
  final LetterModel letter;
  const ListeningPracticeScreen({super.key, required this.letter});

  @override
  State<ListeningPracticeScreen> createState() =>
      _ListeningPracticeScreenState();
}

class _ListeningPracticeScreenState extends State<ListeningPracticeScreen> {
  late final List<String> _options;
  String? _picked;

  @override
  void initState() {
    super.initState();
    final others = arabicLetters
        .map((e) => e.letter)
        .where((l) => l != widget.letter.letter)
        .toList()
      ..shuffle();
    _options = [widget.letter.letter, others[0], others[1]]..shuffle();
  }

  Future<void> _onPick(String l) async {
    if (_picked != null) return;
    setState(() => _picked = l);
    if (l == widget.letter.letter) {
      await Future.delayed(const Duration(milliseconds: 900));
      if (!mounted) return;
      // TODO: mark the letter as completed (Cubit) then go back
      Navigator.of(context).popUntil((r) => r.isFirst);
    } else {
      await Future.delayed(const Duration(milliseconds: 700));
      if (mounted) setState(() => _picked = null); // let her try again
    }
  }

  @override
  Widget build(BuildContext context) {
    return LessonScaffold(
      title: 'تدريب الاستماع',
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                'استمع ثم اختر الحرف الصحيح',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A55B8),
                ),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
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
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  // TODO: play the letter sound
                },
                child: Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4A7BFF).withOpacity(.35),
                        blurRadius: 40,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.volume_up_rounded,
                    size: 90,
                    color: Color(0xFF2F4FD8),
                  ),
                ),
              ),
            ],
          ),

          // Character at the bottom-left
          Positioned(
            left: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Image.asset(AppAssets.teacherThinking, height: 280),
            ),
          ),
        ],
      ),
    );
  }

  _OptionState _stateOf(String l) {
    if (_picked != l) return _OptionState.normal;
    return l == widget.letter.letter ? _OptionState.correct : _OptionState.wrong;
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
      _OptionState.correct => const Color(0xFFAEDDB0),
      _OptionState.wrong => const Color(0xFFF4B4B4),
      _OptionState.normal => LessonColors.card,
    };

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 108,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          letter,
          style: const TextStyle(fontSize: 52, color: LessonColors.navy),
        ),
      ),
    );
  }
}