import 'package:education_children/feature/letters/model/letter_model.dart';
import 'package:flutter/material.dart';
import 'listening_practice_screen.dart';
import 'lesson_widgets.dart';


class SpeakingPracticeScreen extends StatefulWidget {
  final LetterModel letter;
  const SpeakingPracticeScreen({super.key, required this.letter});

  @override
  State<SpeakingPracticeScreen> createState() => _SpeakingPracticeScreenState();
}

class _SpeakingPracticeScreenState extends State<SpeakingPracticeScreen> {
  bool _recording = false;

  void _toggleMic() {
    setState(() => _recording = !_recording);
    // TODO: start / stop recording (record or speech_to_text package)
  }

  @override
  Widget build(BuildContext context) {
    return LessonScaffold(
      title: 'تدريب النطق',
      buttonText: 'متابعة',
      onButtonPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ListeningPracticeScreen(letter: widget.letter),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          const Text(
            'هيا لنقييم النطق',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: LessonColors.navy,
            ),
          ),
          const SizedBox(height: 24),
          LetterCard(letter: widget.letter.letter, height: 168),
          const SizedBox(height: 34),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _WaveBars(
                  heights: const [14, 22, 50, 34, 18, 10],
                  color: LessonColors.green,
                  active: _recording,
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: _toggleMic,
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: LessonColors.green,
                      shape: BoxShape.circle,
                      boxShadow: _recording
                          ? [
                              BoxShadow(
                                color: LessonColors.green.withOpacity(.5),
                                blurRadius: 18,
                                spreadRadius: 4,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      _recording ? Icons.stop_rounded : Icons.mic,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                _WaveBars(
                  heights: const [10, 18, 34, 50, 22, 14],
                  color: Colors.grey,
                  active: _recording,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WaveBars extends StatelessWidget {
  final List<double> heights;
  final Color color;
  final bool active;
  const _WaveBars({
    required this.heights,
    required this.color,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final h in heights)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 2,
              height: active ? h * 1.3 : h,
              color: color.withOpacity(active ? 1 : .6),
            ),
          ),
      ],
    );
  }
}