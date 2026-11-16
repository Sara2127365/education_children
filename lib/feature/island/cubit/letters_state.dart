import 'package:education_children/feature/island/model/letter_model.dart';

abstract class LettersState {}

class LettersInitialState extends LettersState {}

class LettersLoadingState extends LettersState {}

class LettersSuccessState extends LettersState {
  final List<CharacterItemUiModel> letters;
  final Set<int> completedIndexes;
  final int selectedIndex;
  final bool allCompleted;

  LettersSuccessState({
    required this.letters,
    required this.completedIndexes,
    required this.selectedIndex,
    required this.allCompleted,
  });
}

class LettersErrorState extends LettersState {
  final String message;
  final List<CharacterItemUiModel> fallbackLetters;

  LettersErrorState({
    required this.message,
    required this.fallbackLetters,
  });
}

/// نموذج موحد لعرض كل حرف في الواجهة يجمع بين بيانات السيرفر والمحتوى المحلي
class CharacterItemUiModel {
  final int index;
  final int characterId;
  final String letter;
  final String name;
  final bool isUnlocked;
  final bool isCompleted;
  final int starsCount;
  final LetterPositionModel localModel;

  CharacterItemUiModel({
    required this.index,
    required this.characterId,
    required this.letter,
    required this.name,
    required this.isUnlocked,
    required this.isCompleted,
    required this.starsCount,
    required this.localModel,
  });
}
