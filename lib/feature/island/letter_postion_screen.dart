import 'package:education_children/feature/island/model/letter_model.dart';
import 'package:education_children/feature/island/widget/lesson_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// مثال واحد (أول / وسط / آخر الكلمة) - منفصل عن LetterPositionModel بتاع letter_model.dart
class LetterPositionExample {
  final String positionLabel; // أول الكلمة / وسط الكلمة / آخر الكلمة
  final String letterForm; // بـ / ـبـ / ـب
  final String beforeText; // الجزء قبل الحرف المميز
  final String highlighted; // الجزء الأحمر
  final String afterText;
  final String imageAsset;
  final String word; // الكلمة مشكّلة، هي اللي هتتنطق

  const LetterPositionExample({
    required this.positionLabel,
    required this.letterForm,
    required this.highlighted,
    required this.imageAsset,
    required this.word,
    this.beforeText = '',
    this.afterText = '',
  });
}

/// شاشة "مواضع الحرف" - 3 صفحات (أول / وسط / آخر)
class LetterPositionsScreen extends StatefulWidget {
  final LetterPositionModel? letter;
  final VoidCallback onFinished;
  const LetterPositionsScreen({
    super.key,
    this.letter,
    required this.onFinished,
  });

  @override
  State<LetterPositionsScreen> createState() => _LetterPositionsScreenState();
}

class _LetterPositionsScreenState extends State<LetterPositionsScreen> {
  late final List<LetterPositionExample> _items;
  final _controller = PageController();
  final _tts = FlutterTts();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _items = _buildItemsForLetter(widget.letter?.letter ?? 'ب');
    _tts.setLanguage('ar-SA');
    _tts.setSpeechRate(0.4);
  }

  static List<LetterPositionExample> _buildItemsForLetter(String l) {
    if (l == 'أ') {
      return const [
        LetterPositionExample(
          positionLabel: 'أول الكلمة',
          letterForm: 'أَ',
          highlighted: 'أَ',
          afterText: 'رنب',
          imageAsset: 'assets/images/rabbit.png',
          word: 'أَرْنَب',
        ),
        LetterPositionExample(
          positionLabel: 'وسط الكلمة',
          letterForm: 'ـأْـ',
          beforeText: 'فَ',
          highlighted: 'أْ',
          afterText: 'رة',
          imageAsset: 'assets/images/apple.png',
          word: 'فَأْرَة',
        ),
        LetterPositionExample(
          positionLabel: 'آخر الكلمة',
          letterForm: 'ـأ',
          beforeText: 'مَلْجَ',
          highlighted: 'أ',
          imageAsset: 'assets/images/house.png',
          word: 'مَلْجَأ',
        ),
      ];
    } else if (l == 'ت') {
      return const [
        LetterPositionExample(
          positionLabel: 'أول الكلمة',
          letterForm: 'تـ',
          highlighted: 'تُ',
          afterText: 'فاحة',
          imageAsset: 'assets/images/apple.png',
          word: 'تُفَّاحَة',
        ),
        LetterPositionExample(
          positionLabel: 'وسط الكلمة',
          letterForm: 'ـتـ',
          beforeText: 'كِ',
          highlighted: 'تَ',
          afterText: 'اب',
          imageAsset: 'assets/images/duck.png',
          word: 'كِتَاب',
        ),
        LetterPositionExample(
          positionLabel: 'آخر الكلمة',
          letterForm: 'ـت',
          beforeText: 'بَيْ',
          highlighted: 'ت',
          imageAsset: 'assets/images/house.png',
          word: 'بَيْت',
        ),
      ];
    } else if (l == 'ب') {
      return const [
        LetterPositionExample(
          positionLabel: 'أول الكلمة',
          letterForm: 'بـ',
          highlighted: 'بَ',
          afterText: 'قرة',
          imageAsset: 'assets/images/cow.png',
          word: 'بَقَرَة',
        ),
        LetterPositionExample(
          positionLabel: 'وسط الكلمة',
          letterForm: 'ـبـ',
          beforeText: 'حَ',
          highlighted: 'بْ',
          afterText: 'ل',
          imageAsset: 'assets/images/rope.png',
          word: 'حَبْل',
        ),
        LetterPositionExample(
          positionLabel: 'آخر الكلمة',
          letterForm: 'ـب',
          beforeText: 'مرك',
          highlighted: 'ب',
          imageAsset: 'assets/images/boat.png',
          word: 'مَرْكَب',
        ),
      ];
    } else {
      return [
        LetterPositionExample(
          positionLabel: 'أول الكلمة',
          letterForm: '$lـ',
          highlighted: l,
          afterText: '...',
          imageAsset: 'assets/images/duck.png',
          word: l,
        ),
        LetterPositionExample(
          positionLabel: 'وسط الكلمة',
          letterForm: 'ـ$lـ',
          beforeText: '..',
          highlighted: l,
          afterText: '..',
          imageAsset: 'assets/images/duck.png',
          word: l,
        ),
        LetterPositionExample(
          positionLabel: 'آخر الكلمة',
          letterForm: 'ـ$l',
          beforeText: '...',
          highlighted: l,
          imageAsset: 'assets/images/duck.png',
          word: l,
        ),
      ];
    }
  }

  @override
  void dispose() {
    _tts.stop();
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_index == _items.length - 1) {
      widget.onFinished();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LessonScaffold(
      title: 'مواضع الحرف',
      buttonText: _index == _items.length - 1 ? 'متابعة' : 'التالي',
      onButtonPressed: _next,
      child: PageView.builder(
        controller: _controller,
        itemCount: _items.length,
        onPageChanged: (i) {
          _tts.stop();
          setState(() => _index = i);
        },
        itemBuilder: (_, i) => Center(
          child: PositionCard(
            item: _items[i],
            onPlay: () => _tts.speak(_items[i].word),
          ),
        ),
      ),
    );
  }
}

class PositionCard extends StatelessWidget {
  final LetterPositionExample item;
  final VoidCallback onPlay;
  const PositionCard({super.key, required this.item, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 300,
          margin: const EdgeInsets.only(bottom: 28),
          padding: const EdgeInsets.fromLTRB(16, 70, 16, 44),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: SizedBox(
            height: 130,
            child: Row(
              children: [
                Expanded(child: _WordExample(item: item)),
                Container(width: 1.5, height: 130, color: LessonColors.navy),
                Expanded(
                  child: Center(child: Image.asset(item.imageAsset, height: 90)),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -60,
          left: -32,
          right: -32,
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              _OutlinedBox(
                width: 114,
                child: Text(
                  item.positionLabel,
                  style: const TextStyle(fontSize: 20, color: LessonColors.navy),
                ),
              ),
              const Expanded(
                child: Icon(Icons.arrow_back, size: 56, color: Colors.red),
              ),
              _OutlinedBox(
                width: 114,
                child: Text(
                  item.letterForm,
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: LessonColors.navy,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onPlay,
          child: Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: LessonColors.navy,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.volume_up, color: Colors.white, size: 32),
          ),
        ),
      ],
    );
  }
}

class _OutlinedBox extends StatelessWidget {
  final double width;
  final Widget child;
  const _OutlinedBox({required this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 114,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: LessonColors.navy),
      ),
      child: child,
    );
  }
}

class _WordExample extends StatelessWidget {
  final LetterPositionExample item;
  const _WordExample({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text.rich(
          TextSpan(children: [
            TextSpan(text: 'م', style: TextStyle(color: Colors.black)),
            TextSpan(text: 'ث', style: TextStyle(color: Colors.red)),
            TextSpan(text: 'ال', style: TextStyle(color: Colors.black)),
          ]),
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 6),
        Text.rich(
          TextSpan(children: [
            TextSpan(text: item.beforeText),
            TextSpan(
              text: item.highlighted,
              style: const TextStyle(color: Colors.red),
            ),
            TextSpan(text: item.afterText),
          ]),
          style: const TextStyle(fontSize: 38, color: Colors.black),
        ),
      ],
    );
  }
}