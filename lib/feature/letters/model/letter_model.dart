class LetterModel {
  final String letter;
  final String? wordStart; // the highlighted (red) part, e.g. 'بَ'
  final String? wordEnd;   // the rest of the word, e.g. 'طَّةٌ'
  final String? image;
  final String? tip;

  const LetterModel({
    required this.letter,
    this.wordStart,
    this.wordEnd,
    this.image,
    this.tip,
  });
}

const arabicLetters = <LetterModel>[
  LetterModel(letter: 'أ'),
  LetterModel(
    letter: 'ب',
    wordStart: 'بَ',
    wordEnd: 'طَّةٌ',
    image: 'assets/images/duck.png', // move to AppAssets
    tip: 'الحرف (ب) يخرج من الشفتين مع بعضهما وتكون مطلقة ثم تفتح صوت (ب)',
  ),
  LetterModel(letter: 'ت'),
  LetterModel(letter: 'ث'),
  LetterModel(letter: 'ج'),
  LetterModel(letter: 'ح'),
  LetterModel(letter: 'خ'),
  LetterModel(letter: 'د'),
  LetterModel(letter: 'ذ'),
  LetterModel(letter: 'ر'),
  LetterModel(letter: 'ز'),
  LetterModel(letter: 'س'),
  LetterModel(letter: 'ش'),
  LetterModel(letter: 'ص'),
  LetterModel(letter: 'ض'),
  LetterModel(letter: 'ط'),
  LetterModel(letter: 'ظ'),
  LetterModel(letter: 'ع'),
  LetterModel(letter: 'غ'),
  LetterModel(letter: 'ف'),
  LetterModel(letter: 'ق'),
  LetterModel(letter: 'ك'),
  LetterModel(letter: 'ل'),
  LetterModel(letter: 'م'),
  LetterModel(letter: 'ن'),
  LetterModel(letter: 'ه'),
  LetterModel(letter: 'و'),
  LetterModel(letter: 'ي'),
];