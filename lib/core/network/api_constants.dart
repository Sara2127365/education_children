class ApiConstants {
  /// الرابط الأساسي للسيرفر
  static const String baseUrl = 'https://akon.fassla.net/api/v1';

  /// مسارات الـ Auth
  static const String childOnboarding = '/auth/child-onboarding';
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh-token';

  /// مسارات لوحة التحكم الرئيسية والأنشطة (Home Dashboard)
  static const String home = '/home';
  static const String homeActivities = '/home/activities';
  static const String tips = '/tips';

  /// مسارات الجزر والمحرك التعليمي (Learning Islands)
  static const String islands = '/icelands';
  static const String charactersIsland = '/icelands/characters';
  static const String submitStep = '/icelands/steps/submit';
  static const String treasureClaim = '/icelands/treasure/claim';
}
