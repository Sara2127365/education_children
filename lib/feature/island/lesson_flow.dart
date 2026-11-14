import 'package:education_children/feature/island/letter_postion_screen.dart';
import 'package:education_children/feature/island/matching_screen.dart';
import 'package:education_children/feature/island/model/letter_model.dart';
import 'package:education_children/feature/island/speaking_practice_screen.dart';
import 'package:education_children/feature/island/write_letter_screen.dart';
import 'package:flutter/material.dart';

/// يبدأ التمارين بالترتيب: مواضع ← اكتب ← توصيل ← نطق
void startPracticeFlow(BuildContext context, LetterPositionModel letter) {
  void go(Widget screen) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));

  go(
    LetterPositionsScreen(
      onFinished: () => go(
        WriteLetterScreen(
          onContinue: () => go(
            MatchingScreen(
              onContinue: () => go(SpeakingPracticeScreen(letter: letter)),
            ),
          ),
        ),
      ),
    ),
  );
}