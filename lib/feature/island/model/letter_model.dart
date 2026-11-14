class LetterPositionModel {
  final String letter;
  final String? wordStart;
  final String? wordEnd;
  final String? image;
  final String? tip; // نص شاشة "تذكر"

  const LetterPositionModel({
    required this.letter,
    this.wordStart,
    this.wordEnd,
    this.image,
    this.tip,
  });
}