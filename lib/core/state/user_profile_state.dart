import 'package:education_children/feature/auth/signup/sign_up_option.dart';
import 'package:flutter/foundation.dart';

/// إدارة الملف الشخصي للطفل وحالة الجلسة الحالية
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

  // بيانات المصادقة والتقدم المالي والنقاط
  static final ValueNotifier<String?> token = ValueNotifier<String?>(null);
  static final ValueNotifier<int> coins = ValueNotifier<int>(100);
  static final ValueNotifier<int> stars = ValueNotifier<int>(0);
  static final ValueNotifier<String> currentIsland =
      ValueNotifier<String>('characters');

  static bool get isGirl => gender.value == Gender.girl;
  static bool get isBoy => gender.value == Gender.boy;
  static bool get isAuthenticated => token.value != null && token.value!.isNotEmpty;

  static void update({
    String? newName,
    Gender? newGender,
    GuideType? newGuide,
    int? newAge,
    Dialect? newDialect,
    String? newLanguage,
    String? newToken,
    int? newCoins,
    int? newStars,
    String? newCurrentIsland,
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
    if (newToken != null && newToken.isNotEmpty) {
      token.value = newToken;
    }
    if (newCoins != null) {
      coins.value = newCoins;
    }
    if (newStars != null) {
      stars.value = newStars;
    }
    if (newCurrentIsland != null && newCurrentIsland.isNotEmpty) {
      currentIsland.value = newCurrentIsland;
    }
  }

  static void clearSession() {
    token.value = null;
    coins.value = 100;
    stars.value = 0;
    currentIsland.value = 'characters';
  }
}
