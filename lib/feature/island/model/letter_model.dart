class LetterPositionModel {
  final String letter;
  final String? wordStart;
  final String? wordEnd;
  final String? image;
  final String? tip;

  const LetterPositionModel({
    required this.letter,
    this.wordStart,
    this.wordEnd,
    this.image,
    this.tip,
  });
}

const List<LetterPositionModel> arabicLetters = [
  LetterPositionModel(
    letter: 'أ',
    wordStart: 'أَرْنَب',
    tip: 'حرف الألف هو أول الحروف الهجائية، يُكتب كعصا وفوقه همزة، مثل أرنب وأسد.',
  ),
  LetterPositionModel(
    letter: 'ب',
    wordStart: 'بَقَرَة',
    tip: 'حرف الباء يشبه طبقاً جميلاً وتحته نقطة واحدة، مثل بقرة وبطة.',
  ),
  LetterPositionModel(
    letter: 'ت',
    wordStart: 'تُفَّاحَة',
    tip: 'حرف التاء طبق وفوقه نقطتان تبتسمان، مثل تفاحة وتمر.',
  ),
  LetterPositionModel(
    letter: 'ث',
    wordStart: 'ثَعْلَب',
    tip: 'حرف الثاء طبق وفوقه ثلاث نقاط، ونخرج فيه طرف لساننا، مثل ثعلب وثوب.',
  ),
  LetterPositionModel(
    letter: 'ج',
    wordStart: 'جَمَل',
    tip: 'حرف الجيم له بطن كبير وفيه نقطة واحدة، مثل جمل وجزر.',
  ),
  LetterPositionModel(
    letter: 'ح',
    wordStart: 'حِصَان',
    tip: 'حرف الحاء يشبه الجيم ولكنه بدون أي نقاط، مثل حصان وحلوى.',
  ),
  LetterPositionModel(
    letter: 'خ',
    wordStart: 'خَرُوف',
    tip: 'حرف الخاء فوق رأسه نقطة واحدة، مثل خروف وخيار.',
  ),
  LetterPositionModel(
    letter: 'د',
    wordStart: 'دُب',
    tip: 'حرف الدال خط مائل ثم خط على السطر، مثل دبدوب وديك.',
  ),
  LetterPositionModel(
    letter: 'ذ',
    wordStart: 'ذِئْب',
    tip: 'حرف الذال مثل الدال وفوقه نقطة، نخرج فيه لساننا، مثل ذئب وذرة.',
  ),
  LetterPositionModel(
    letter: 'ر',
    wordStart: 'رُمَّان',
    tip: 'حرف الراء يتزحلق تحت السطر مثل الموزة، مثل رمان وريشة.',
  ),
  LetterPositionModel(
    letter: 'ز',
    wordStart: 'زَرَافَة',
    tip: 'حرف الزاي مثل الراء وفوقه نقطة لامعة، مثل زرافة وزيتون.',
  ),
  LetterPositionModel(
    letter: 'س',
    wordStart: 'سَمَكَة',
    tip: 'حرف السين له ثلاثة أسنان وصحن واسع، مثل سمكة وساعة.',
  ),
  LetterPositionModel(
    letter: 'ش',
    wordStart: 'شَمْس',
    tip: 'حرف الشين مثل السين وفوقه ثلاث نقاط، مثل شمس وشجرة.',
  ),
  LetterPositionModel(
    letter: 'ص',
    wordStart: 'صَقْر',
    tip: 'حرف الصاد له عين بيضاوية وصحن واسع، مثل صقر وصابون.',
  ),
  LetterPositionModel(
    letter: 'ض',
    wordStart: 'ضِفْدَع',
    tip: 'حرف الضاد مثل الصاد وفوقه نقطة، وهو حرف لغتنا الجميلة، مثل ضفدع وضوء.',
  ),
  LetterPositionModel(
    letter: 'ط',
    wordStart: 'طَائِرَة',
    tip: 'حرف الطاء له شكل بيضاوي وعصا طويلة، مثل طائرة وطبلة.',
  ),
  LetterPositionModel(
    letter: 'ظ',
    wordStart: 'ظَبْي',
    tip: 'حرف الظاء مثل الطاء وفوقه نقطة، ونخرج فيه لساننا، مثل ظبي وظرف.',
  ),
  LetterPositionModel(
    letter: 'ع',
    wordStart: 'عُصْفُور',
    tip: 'حرف العين نصف دائرة صغيرة ونصف دائرة كبيرة، مثل عصفور وعنب.',
  ),
  LetterPositionModel(
    letter: 'غ',
    wordStart: 'غَزَال',
    tip: 'حرف الغين مثل العين وفوقه نقطة، مثل غزال وغيمة.',
  ),
  LetterPositionModel(
    letter: 'ف',
    wordStart: 'فَرَاشَة',
    tip: 'حرف الفاء دائرة صغيرة فوق طبق وفوقها نقطة، مثل فراشة وفيل.',
  ),
  LetterPositionModel(
    letter: 'ق',
    wordStart: 'قِرْد',
    tip: 'حرف القاف دائرة فوق صحن عميق وفوقها نقطتان، مثل قرد وقمر.',
  ),
  LetterPositionModel(
    letter: 'ك',
    wordStart: 'كِتَاب',
    tip: 'حرف الكاف خط مستقيم وفي بطنه همزة صغيرة، مثل كتاب وكلب.',
  ),
  LetterPositionModel(
    letter: 'ل',
    wordStart: 'لَيْمُون',
    tip: 'حرف اللام كعصا المظلة ينزل تحت السطر، مثل ليمون ولعبة.',
  ),
  LetterPositionModel(
    letter: 'م',
    wordStart: 'مَوْز',
    tip: 'حرف الميم دائرة صغيرة تنزل منها عصا تحت السطر، مثل موز ومسجد.',
  ),
  LetterPositionModel(
    letter: 'ن',
    wordStart: 'نَجْمَة',
    tip: 'حرف النون صحن مستدير وبداخله نقطة، مثل نجمة ونحل.',
  ),
  LetterPositionModel(
    letter: 'ه',
    wordStart: 'هَدِيَّة',
    tip: 'حرف الهاء دائرة جميلة مثل الوردة، مثل هدية وهلال.',
  ),
  LetterPositionModel(
    letter: 'و',
    wordStart: 'وَرْدَة',
    tip: 'حرف الواو رأس مستدير وجسم يتزحلق، مثل وردة ووسادة.',
  ),
  LetterPositionModel(
    letter: 'ي',
    wordStart: 'يَمَامَة',
    tip: 'حرف الياء كالبطة السابحة وتحتها نقطتان، مثل يد ويمامة.',
  ),
];
