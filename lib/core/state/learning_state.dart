import 'package:flutter/foundation.dart';

class LearningProgress {
  // الحروف المكتملة - افتراضياً حرف "أ" مكتمل كما في الصورة الأولى
  static final ValueNotifier<Set<int>> completedLetters =
      ValueNotifier<Set<int>>({0});

  // الحرف المحدد حالياً - افتراضياً حرف "ب" كما في الصورة الأولى
  static final ValueNotifier<int> selectedIndex = ValueNotifier<int>(1);

  static void completeLetter(int index) {
    final next = Set<int>.from(completedLetters.value)..add(index);
    completedLetters.value = next;
    // الانتقال تلقائياً للحرف التالي
    selectedIndex.value = (index + 1) % 28;
  }
}
