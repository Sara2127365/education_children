import 'package:education_children/feature/letters/model/letter_model.dart';
import 'package:education_children/feature/letters/remember_screen.dart';
import 'package:flutter/material.dart';
import 'lesson_widgets.dart';


class LearnLetterScreen extends StatelessWidget {
  final LetterModel letter;
  const LearnLetterScreen({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return LessonScaffold(
      title: 'تلعم الحرف',
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
            // Lower card (picture + word)
            Positioned(
              top: 85,
              left: 0,
              right: 0,
              child: Container(
                height: 295,
                decoration: BoxDecoration(
                  color: LessonColors.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: LessonColors.yellow),
                ),
                padding: const EdgeInsets.only(top: 80),
                child: Row(
                  children: [
                    // Word (right side in RTL)
                    Expanded(
                      child: Center(
                        child: RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 48,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: letter.wordStart ?? '',
                                style: const TextStyle(color: Colors.red),
                              ),
                              TextSpan(text: letter.wordEnd ?? ''),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(width: 1, height: 165, color: Colors.black54),
                    // Picture (left side in RTL)
                    Expanded(
                      child: Center(
                        child: letter.image == null
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(letter.image!),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Speaker (top-left corner of the lower card)
            Positioned(
              top: 100,
              left: 16,
              child: SpeakerButton(
                size: 54,
                onTap: () {
                  // TODO: play the word audio
                },
              ),
            ),

            // Big letter card (above everything)
            LetterCard(letter: letter.letter),
          ],
        ),
      ),
    );
  }
}