import 'package:education_children/feature/letters/model/letter_model.dart';
import 'package:education_children/feature/letters/speaking_practice_screen.dart';
import 'package:flutter/material.dart';
import 'lesson_widgets.dart';

class RememberScreen extends StatelessWidget {
  final LetterModel letter;
  const RememberScreen({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return LessonScaffold(
      title: 'تذكر',
      buttonText: 'حسنا',
      onButtonPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SpeakingPracticeScreen(letter: letter),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              height: 312,
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              decoration: BoxDecoration(
                color: LessonColors.card,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: LessonColors.yellow),
              ),
              child: Text(
                letter.tip ?? '',
                style: const TextStyle(
                  fontSize: 28,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            // Speaker button on the bottom edge of the card
            Positioned(
              top: 292,
              child: SpeakerButton(
                size: 54,
                outlined: true,
                onTap: () {
                  // TODO: play the explanation audio
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}