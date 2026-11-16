import 'package:education_children/feature/auth/signup/sign_up_option.dart';
import 'package:flutter/foundation.dart';

/// إدارة الملف الشخصي للطفل (الاسم، النوع، الموجه، اللهجة، اللغة)
class UserProfile {
  static final ValueNotifier<String> name = ValueNotifier<String>('عمر');
  static final ValueNotifier<Gender> gender = ValueNotifier<Gender>(Gender.boy);
  static final ValueNotifier<GuideType> guide =
      ValueNotifier<GuideType>(GuideType.male);
  static final ValueNotifier<int> age = ValueNotifier<int>(7);
  static final ValueNotifier<Dialect> dialect =
      ValueNotifier<Dialect>(Dialect.gulf);
  static final ValueNotifier<String> language =
      ValueNotifier<String>('ar');

  static bool get isGirl => gender.value == Gender.girl;
  static bool get isBoy => gender.value == Gender.boy;

  static void update({
    String? newName,
    Gender? newGender,
    GuideType? newGuide,
    int? newAge,
    Dialect? newDialect,
    String? newLanguage,
  }) {
    if (newName != null && newName.trim().isNotEmpty) {
      name.value = newName.trim();
    }
    if (newGender != null) {
      gender.value = newGender;
    }
    if (newGuide != null) {
      guide.value = newGuide;
    }
    if (newAge != null) {
      age.value = newAge;
    }
    if (newDialect != null) {
      dialect.value = newDialect;
    }
    if (newLanguage != null && newLanguage.trim().isNotEmpty) {
      language.value = newLanguage.trim();
    }
  }
}
