import 'package:education_children/feature/letters/learn_letter_screen.dart';
import 'package:education_children/feature/letters/lesson_widgets.dart';
import 'package:education_children/feature/letters/model/letter_model.dart';
import 'package:flutter/material.dart';


class LettersIslandScreen extends StatefulWidget {
  const LettersIslandScreen({super.key});

  @override
  State<LettersIslandScreen> createState() => _LettersIslandScreenState();
}

class _LettersIslandScreenState extends State<LettersIslandScreen> {
  final Set<int> _completed = {0}; // أ done (later: load from Cubit / storage)
  int _selected = 1;               // ب is the current letter

  @override
  Widget build(BuildContext context) {
    return LessonScaffold(
      title: 'جزيرة الحروف',
      showBack: false,
      buttonText: 'متابعة',
      onButtonPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LearnLetterScreen(letter: arabicLetters[_selected]),
        ),
      ),
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
        itemCount: arabicLetters.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 8,
          childAspectRatio: 1.02,
        ),
        itemBuilder: (_, i) => _LetterTile(
          letter: arabicLetters[i].letter,
          completed: _completed.contains(i),
          selected: i == _selected,
          onTap: () => setState(() => _selected = i),
        ),
      ),
    );
  }
}

class _LetterTile extends StatelessWidget {
  final String letter;
  final bool completed;
  final bool selected;
  final VoidCallback onTap;

  const _LetterTile({
    required this.letter,
    required this.completed,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = LessonColors.card;
    Color? border;
    if (completed) {
      bg = const Color(0xFFAEDDB0);
      border = const Color(0xFF3E9E45);
    } else if (selected) {
      bg = const Color(0xFFADCBDB);
      border = LessonColors.navy;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: border == null ? null : Border.all(color: border),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                letter,
                style: const TextStyle(
                  fontSize: 52,
                  color: LessonColors.navy,
                ),
              ),
            ),
            if (completed)
              const Positioned(
                top: 8,
                left: 8,
                child: CircleAvatar(
                  radius: 11,
                  backgroundColor: Color(0xFF2E9A3D),
                  child: Icon(Icons.check, size: 15, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}