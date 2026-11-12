enum Gender { girl, boy }

enum GuideType { female, male }

enum Dialect { gulf, egyptian, fusha }

class LanguageOption {
  final String code;
  final String label;
  const LanguageOption(this.code, this.label);
}

const languageOptions = [
  LanguageOption('ar', 'العربية'),
  LanguageOption('en', 'English'),
  LanguageOption('tr', 'Türkçe'),
  LanguageOption('ur', 'اردو'),
];