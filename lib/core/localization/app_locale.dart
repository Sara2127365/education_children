import 'package:education_children/core/localization/app_strings.dart';
import 'package:education_children/core/state/user_profile_state.dart';
import 'package:flutter/material.dart';

/// إدارة حالة اللغة الحالية والاتجاه والترجمة في التطبيق (Core Localization)
class AppLocale {
  /// رمز اللغة الحالية (الافتراضي: 'ar')
  static final ValueNotifier<String> currentLocale =
      ValueNotifier<String>('ar');

  /// قائمة اللغات المدعومة
  static const List<String> supportedLanguages = ['ar', 'en', 'tr', 'ur'];

  /// استرجاع كود اللغة الحالية
  static String get languageCode => currentLocale.value;

  /// هل اتجاه اللغة الحالية من اليمين إلى اليسار (RTL)
  static bool get isRtl =>
      currentLocale.value == 'ar' || currentLocale.value == 'ur';

  /// اتجاه النص العام بناءً على اللغة الحالية
  static TextDirection get textDirection =>
      isRtl ? TextDirection.rtl : TextDirection.ltr;

  /// تغيير اللغة مع تحديث حالة التطبيق وملف المستخدم
  static void changeLanguage(String code) {
    if (!supportedLanguages.contains(code)) {
      code = 'ar';
    }
    if (currentLocale.value != code) {
      currentLocale.value = code;
      UserProfile.language.value = code;
    }
  }

  /// دالة الترجمة السريعة
  static String tr(String key, {Map<String, String>? params}) {
    return AppStrings.get(key, lang: currentLocale.value, params: params);
  }
}

/// امتداد لتسهيل الترجمة من أي نص
extension StringTranslateExtension on String {
  String tr({Map<String, String>? params}) {
    return AppLocale.tr(this, params: params);
  }
}

/// امتداد لتسهيل الوصول للغة والاتجاه من الـ BuildContext
extension BuildContextLocaleExtension on BuildContext {
  String tr(String key, {Map<String, String>? params}) {
    return AppLocale.tr(key, params: params);
  }

  bool get isRtl => AppLocale.isRtl;

  TextDirection get textDirection => AppLocale.textDirection;
}
