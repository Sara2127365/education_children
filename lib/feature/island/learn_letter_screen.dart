import 'package:education_children/feature/island/model/letter_model.dart';
import 'package:education_children/feature/island/remember_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'widget/lesson_widgets.dart';

class LearnLetterScreen extends StatefulWidget {
  final LetterPositionModel letter;
  const LearnLetterScreen({super.key, required this.letter});

  @override
  State<LearnLetterScreen> createState() => _LearnLetterScreenState();
}

class _LearnLetterScreenState extends State<LearnLetterScreen> {
  final _tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _tts.setLanguage('ar-SA');
    _tts.setSpeechRate(0.4);
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _speakWord() async {
    final word = '${widget.letter.wordStart ?? ''}${widget.letter.wordEnd ?? ''}';
    if (word.isEmpty) return;
    await _tts.stop();
    await _tts.speak(word);
  }

  @override
  Widget build(BuildContext context) {
    final letter = widget.letter;

    return LessonScaffold(
      title: 'تعلم الحرف',
      buttonText: 'متابعة',
      onButtonPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RememberScreen(letter: letter)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 24, 18, 0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // ... نفس الـ Positioned بتاع الكارت السفلي من غير أي تغيير ...

            Positioned(
              top: 100,
              left: 16,
              child: SpeakerButton(
                size: 54,
                onTap: _speakWord,
              ),
            ),

           LetterCard(letter: letter.letter),
          ],
        ),
      ),
    );
  }
}