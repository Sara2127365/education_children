import 'package:education_children/core/network/api_constants.dart';
import 'package:education_children/core/network/api_service.dart';
import 'package:education_children/core/state/learning_state.dart';
import 'package:education_children/core/state/user_profile_state.dart';
import 'package:education_children/feature/island/cubit/letters_state.dart';
import 'package:education_children/feature/island/model/character_progress_model.dart';
import 'package:education_children/feature/island/model/letter_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LettersCubit extends Cubit<LettersState> {
  LettersCubit() : super(LettersInitialState());

  List<CharacterItemUiModel> _letters = [];
  Set<int> _completedIndexes = {};
  int _selectedIndex = 0;

  /// جلب تقدم الحروف الـ 28 من السيرفر
  Future<void> fetchLetters() async {
    emit(LettersLoadingState());

    try {
      final jsonResponse = await ApiService.get(
        url: '${ApiConstants.baseUrl}${ApiConstants.charactersIsland}',
      );

      final apiCharacters = <CharacterProgressModel>[];
      final data = jsonResponse['data'];
      if (data is List) {
        for (final item in data) {
          if (item is Map<String, dynamic>) {
            apiCharacters.add(CharacterProgressModel.fromJson(item));
          }
        }
      }

      _letters = _buildUnifiedLetters(apiCharacters);

      _completedIndexes = _letters
          .where((l) => l.isCompleted)
          .map((l) => l.index)
          .toSet();

      // تحديث حالة التعلم المركزية
      LearningProgress.completedLetters.value = _completedIndexes;

      // تحديد الحرف المختار تلقائياً: أول حرف مفتوح غير مكتمل
      _selectedIndex = _letters.indexWhere((l) => l.isUnlocked && !l.isCompleted);
      if (_selectedIndex < 0) {
        _selectedIndex = _letters.indexWhere((l) => !l.isCompleted);
        if (_selectedIndex < 0) _selectedIndex = 0;
      }
      LearningProgress.selectedIndex.value = _selectedIndex;

      final allDone = _completedIndexes.length == arabicLetters.length;

      emit(LettersSuccessState(
        letters: _letters,
        completedIndexes: _completedIndexes,
        selectedIndex: _selectedIndex,
        allCompleted: allDone,
      ));
    } catch (e) {
      // في حال حدوث خطأ أو العمل بدون إنترنت، يتم الاعتماد على البيانات المحلية الآمنة
      _letters = _buildFallbackLetters();
      _completedIndexes = LearningProgress.completedLetters.value;
      _selectedIndex = LearningProgress.selectedIndex.value;

      emit(LettersErrorState(
        message: e.toString().replaceAll('Exception: ', ''),
        fallbackLetters: _letters,
      ));
    }
  }

  /// تغيير الحرف المختار
  void selectLetter(int index) {
    if (index >= 0 && index < _letters.length) {
      _selectedIndex = index;
      LearningProgress.selectedIndex.value = index;

      emit(LettersSuccessState(
        letters: _letters,
        completedIndexes: _completedIndexes,
        selectedIndex: _selectedIndex,
        allCompleted: _completedIndexes.length == arabicLetters.length,
      ));
    }
  }

  /// إرسال إجابة تمرين وحفظ التقدم في السيرفر
  static Future<Map<String, dynamic>?> submitStep({
    required int characterId,
    required int stepNumber,
    required bool isCorrect,
    int score = 10,
  }) async {
    try {
      final response = await ApiService.post(
        url: '${ApiConstants.baseUrl}${ApiConstants.submitStep}',
        body: {
          'island_type': 'characters',
          'module_id': characterId.toString(),
          'step_number': stepNumber,
          'is_correct': isCorrect,
          'score': score,
          'time_spent_seconds': 10,
        },
      );

      final data = response['data'];
      if (data is Map<String, dynamic>) {
        final stars = data['stars_earned'];
        final coins = data['coins_earned'];
        if (stars is int && stars > 0) {
          UserProfile.stars.value += stars;
        }
        if (coins is int && coins > 0) {
          UserProfile.coins.value += coins;
        }
      }

      return response;
    } catch (_) {
      return null;
    }
  }

  /// دمج استجابة الـ API مع الحروف الـ 28 المحلية
  List<CharacterItemUiModel> _buildUnifiedLetters(
    List<CharacterProgressModel> apiList,
  ) {
    final result = <CharacterItemUiModel>[];

    for (int i = 0; i < arabicLetters.length; i++) {
      final local = arabicLetters[i];

      final matched = apiList.firstWhere(
        (api) => api.character == local.letter || api.name.contains(local.letter),
        orElse: () => CharacterProgressModel(
          characterId: i + 1,
          character: local.letter,
          name: local.letter,
          isUnlocked: i == 0,
          isCompleted: false,
          starsCount: 0,
          totalSteps: 6,
        ),
      );

      // أول حرف مفتوح دائماً
      final isUnlocked = i == 0 ? true : matched.isUnlocked;

      result.add(CharacterItemUiModel(
        index: i,
        characterId: matched.characterId > 0 ? matched.characterId : (i + 1),
        letter: local.letter,
        name: matched.name.isNotEmpty ? matched.name : local.letter,
        isUnlocked: isUnlocked,
        isCompleted: matched.isCompleted,
        starsCount: matched.starsCount,
        localModel: local,
      ));
    }

    return result;
  }

  /// بناء قائمة الحروف المحلية عند عدم توفر اتصال
  List<CharacterItemUiModel> _buildFallbackLetters() {
    final completed = LearningProgress.completedLetters.value;
    final result = <CharacterItemUiModel>[];

    for (int i = 0; i < arabicLetters.length; i++) {
      final local = arabicLetters[i];
      final isDone = completed.contains(i);
      final isUnlocked = i == 0 || completed.contains(i - 1) || isDone;

      result.add(CharacterItemUiModel(
        index: i,
        characterId: i + 1,
        letter: local.letter,
        name: local.letter,
        isUnlocked: isUnlocked,
        isCompleted: isDone,
        starsCount: isDone ? 3 : 0,
        localModel: local,
      ));
    }

    return result;
  }
}
