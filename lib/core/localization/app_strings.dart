/// القاموس الشامل للترجمة والنصوص لجميع اللغات المدعومة
/// اللغات المدعومة: العربية (ar)، الإنجليزية (en)، التركية (tr)، الأردية (ur)
class AppStrings {
  static const Map<String, Map<String, String>> _values = {
    // =========================================================================
    // 1. اللغة العربية (ar)
    // =========================================================================
    'ar': {
      // شاشة البداية والدخول
      'app_title': 'أكون',
      'welcome_back': 'أهلاً بعودتك!',
      'login_subtitle': 'سجل دخولك لتكمل مغامرتك وتجمع المزيد من النجوم',
      'login': 'تسجيل الدخول',
      'create_account': 'إنشاء حساب جديد',
      'no_account': 'ليس لديك حساب؟',
      'already_have_account': 'لديك حساب بالفعل؟',
      'new_registration': 'تسجيل جديد',
      'forgot_password': 'هل نسيت كلمة المرور ؟',
      'email': 'البريد الإلكتروني',
      'enter_email': 'اكتب البريد الإلكتروني',
      'invalid_email': 'البريد غير صحيح',
      'password': 'كلمة المرور',
      'enter_password': 'أدخل كلمة المرور',
      'phone': 'رقم الهاتف',
      'invalid_phone': 'رقم الهاتف غير صحيح',

      // إنشاء الحساب (Signup)
      'child_name': 'اسم الطفل',
      'enter_child_name': 'اكتب اسم الطفل',
      'age': 'العمر',
      'how_old': 'كم عمرك؟',
      'enter_age': 'اكتب العمر',
      'gender': 'النوع',
      'boy': 'ولد',
      'girl': 'بنت',
      'guide_info': 'بيانات الموجة',
      'choose_guide': 'اختر من سيوجه رحلتك التعليمية',
      'female_teacher': 'معلمة',
      'female': 'انثى',
      'male_teacher': 'معلم',
      'male': 'ذكر',
      'choose_language': 'اختر لغتك',
      'choose_dialect': 'اختر اللهجة المفضلة',
      'dialect_gulf': 'خليجي',
      'dialect_egyptian': 'مصري',
      'dialect_fusha': 'فصحى',
      'parents_section': 'قسم الوالدين',
      'select_gender_and_guide': 'من فضلك اختر النوع والموجه',
      'let_us_start': 'هيا بنا ، نبدأ',

      // شاشات المعلم والمعلمة
      'teacher_greeting_boy':
          'مرحبا بك في أكون! سأكون معلمك ومساعدك في رحلتك للتعلم وتصبح بطلاً في القراءة',
      'teacher_greeting_girl':
          'مرحبا بكِ في أكون! سأكون معلمتكِ ومساعدتكِ في رحلتكِ للتعلم وتصبحي بطلةً في القراءة',
      'next': 'التالي',

      // الشاشة الرئيسية (Home)
      'good_morning': 'صباح الخير يا {name} !',
      'continue_journey': 'هيا نكمل رحلتنا التعليمية',
      'island_letters': 'جزيرة الحروف',
      'island_diacritics': 'جزيرة الحركات',
      'island_long_vowels': 'جزيرة حروف المد',
      'island_words': 'جزيرة الكلمات',
      'island_sentences': 'جزيرة الجمل والقواعد',
      'island_treasure': 'الكنز الكبير',
      'home_speech_boy':
          'الآن حان وقت الإبحار\nإلى جزيرة الحركات\nلتتعلم الفتحة والضمة\nوالكسرة و....هيا بنا!',
      'home_speech_girl':
          'الآن حان وقت الإبحار\nإلى جزيرة الحركات\nلتتعلمي الفتحة والضمة\nوالكسرة و....هيا بنا!',

      // الدروس والأنشطة وجزيرة الحروف
      'letters_island_title': 'جزيرة الحروف',
      'continue_btn': 'متابعة',
      'start_btn': 'انطلق',
      'awesome': 'رائع',
      'well_done': 'أحسنت!',
      'well_done_hero_boy': 'أحسنت أيها البطل',
      'well_done_hero_girl': 'أحسنتِ أيتها البطلة',
      'wrong_answer': 'اجابة خاطئة ، حاول مرة أخرى',
      'listening_practice': 'تدريب الاستماع',
      'listen_and_choose': 'استمع ثم اختر الحرف الصحيح',
      'write_letter': 'كتابة الحرف',
      'learn_letter': 'تعلم الحرف',
      'letter_positions': 'مواضع الحرف',
      'clear': 'مسح',
      'you_earned_coins': 'لقد حصلت علي 20 عملة ذهبية',
      'all_letters_completed_title': 'ممتاز!',
      'all_letters_completed_desc': 'الآن أصبحت\nتعرف جميع\nالحروف.',
      'lets_start_new_journey': 'هيا بنا نبدأ\nرحلة جديدة',

      // شاشات الاشتراكات والدفع
      'subscribers_only_title': 'هذه الجزيرة متاحة\nللمشتركين فقط',
      'unlock_all_islands': 'اشترك الآن لفتح جميع الجزر',
      'subscribe_now': 'اشترك الآن',
      'back_to_map': 'رجوع للخريطة',
      'subscriptions': 'الاشتراكات',
      'one_child': 'طفل واحد',
      'two_children': 'طفلان',
      'three_children': '3 أطفال',
      'suitable_for_one': 'مناسب لطفل واحد',
      'suitable_for_two': 'مناسب لطفلين',
      'suitable_for_three': 'مناسب لـ 3 أطفال',
      'most_popular': 'الأكثر اختياراً',
      'sar': 'ريال',
      'instead_of': 'بدل',
      'proceed_to_payment': 'متابعة للدفع',
      'important_info': 'معلومات مهمة',
      'all_features': 'جميع المميزات',
      'separate_profiles': 'إنشاء حسابين للأطفال',
      'separate_tracking': 'متابعة كل طفل بشكل منفصل',
      'detailed_reports': 'تقارير لكل طفل',
      'best_saving': 'توفير أفضل',
      'updated_content': 'محتوى متجدد',
      'secure_payment': 'دفع آمن 100%',
    },

    // =========================================================================
    // 2. English (en)
    // =========================================================================
    'en': {
      // Splash & Auth
      'app_title': 'Acoon',
      'welcome_back': 'Welcome Back!',
      'login_subtitle':
          'Log in to continue your adventure and collect more stars',
      'login': 'Log In',
      'create_account': 'Create New Account',
      'no_account': "Don't have an account?",
      'already_have_account': 'Already have an account?',
      'new_registration': 'Sign Up',
      'forgot_password': 'Forgot password?',
      'email': 'Email',
      'enter_email': 'Enter your email',
      'invalid_email': 'Invalid email address',
      'password': 'Password',
      'enter_password': 'Enter your password',
      'phone': 'Phone Number',
      'invalid_phone': 'Invalid phone number',

      // Signup
      'child_name': 'Child Name',
      'enter_child_name': 'Enter child name',
      'age': 'Age',
      'how_old': 'How old are you?',
      'enter_age': 'Enter age',
      'gender': 'Gender',
      'boy': 'Boy',
      'girl': 'Girl',
      'guide_info': 'Guide Info',
      'choose_guide': 'Choose who will guide your learning journey',
      'female_teacher': 'Teacher (F)',
      'female': 'Female',
      'male_teacher': 'Teacher (M)',
      'male': 'Male',
      'choose_language': 'Choose your language',
      'choose_dialect': 'Choose preferred dialect',
      'dialect_gulf': 'Gulf',
      'dialect_egyptian': 'Egyptian',
      'dialect_fusha': 'Standard Arabic',
      'parents_section': 'Parents Section',
      'select_gender_and_guide': 'Please select gender and guide',
      'let_us_start': "Let's Start",

      // Teacher Screen
      'teacher_greeting_boy':
          'Welcome to Acoon! I will be your teacher and helper on your learning journey to become a reading champion!',
      'teacher_greeting_girl':
          'Welcome to Acoon! I will be your teacher and helper on your learning journey to become a reading champion!',
      'next': 'Next',

      // Home Screen
      'good_morning': 'Good morning, {name}!',
      'continue_journey': "Let's continue our learning journey",
      'island_letters': 'Letters Island',
      'island_diacritics': 'Diacritics Island',
      'island_long_vowels': 'Long Vowels Island',
      'island_words': 'Words Island',
      'island_sentences': 'Sentences & Grammar',
      'island_treasure': 'The Big Treasure',
      'home_speech_boy':
          "Now it's time to sail\nto Diacritics Island\nto learn Fatha, Damma,\nKasra... Let's go!",
      'home_speech_girl':
          "Now it's time to sail\nto Diacritics Island\nto learn Fatha, Damma,\nKasra... Let's go!",

      // Island & Letters
      'letters_island_title': 'Letters Island',
      'continue_btn': 'Continue',
      'start_btn': 'Go!',
      'awesome': 'Awesome',
      'well_done': 'Well done!',
      'well_done_hero_boy': 'Well done, Hero!',
      'well_done_hero_girl': 'Well done, Heroine!',
      'wrong_answer': 'Incorrect answer, try again',
      'listening_practice': 'Listening Practice',
      'listen_and_choose': 'Listen and choose the correct letter',
      'write_letter': 'Write the Letter',
      'learn_letter': 'Learn the Letter',
      'letter_positions': 'Letter Positions',
      'clear': 'Clear',
      'you_earned_coins': 'You received 20 gold coins',
      'all_letters_completed_title': 'Excellent!',
      'all_letters_completed_desc': 'Now you\nknow all the\nletters.',
      'lets_start_new_journey': "Let's start a\nnew journey",

      // Subscriptions & Plans
      'subscribers_only_title': 'This island is available\nfor subscribers only',
      'unlock_all_islands': 'Subscribe now to unlock all islands',
      'subscribe_now': 'Subscribe Now',
      'back_to_map': 'Back to Map',
      'subscriptions': 'Subscriptions',
      'one_child': '1 Child',
      'two_children': '2 Children',
      'three_children': '3 Children',
      'suitable_for_one': 'Suitable for 1 child',
      'suitable_for_two': 'Suitable for 2 children',
      'suitable_for_three': 'Suitable for 3 children',
      'most_popular': 'Most Popular',
      'sar': 'SAR',
      'instead_of': 'instead of',
      'proceed_to_payment': 'Proceed to Payment',
      'important_info': 'Important Information',
      'all_features': 'All features included',
      'separate_profiles': 'Two separate child profiles',
      'separate_tracking': 'Track each child separately',
      'detailed_reports': 'Detailed reports for each child',
      'best_saving': 'Best Value',
      'updated_content': 'Continuously updated content',
      'secure_payment': '100% Secure Payment',
    },

    // =========================================================================
    // 3. Türkçe (tr)
    // =========================================================================
    'tr': {
      // Giriş ve Başlangıç
      'app_title': 'Acoon',
      'welcome_back': 'Tekrar Hoş Geldiniz!',
      'login_subtitle':
          'Macerana devam etmek ve daha fazla yıldız toplamak için giriş yap',
      'login': 'Giriş Yap',
      'create_account': 'Yeni Hesap Oluştur',
      'no_account': 'Hesabınız yok mu?',
      'already_have_account': 'Zaten hesabınız var mı?',
      'new_registration': 'Kayıt Ol',
      'forgot_password': 'Şifrenizi mi unuttunuz?',
      'email': 'E-posta',
      'enter_email': 'E-postanızı girin',
      'invalid_email': 'Geçersiz e-posta adresi',
      'password': 'Şifre',
      'enter_password': 'Şifrenizi girin',
      'phone': 'Telefon Numarası',
      'invalid_phone': 'Geçersiz telefon numarası',

      // Kayıt Formu
      'child_name': 'Çocuğun Adı',
      'enter_child_name': 'Çocuğun adını yazın',
      'age': 'Yaş',
      'how_old': 'Kaç yaşındasın?',
      'enter_age': 'Yaşı girin',
      'gender': 'Cinsiyet',
      'boy': 'Erkek',
      'girl': 'Kız',
      'guide_info': 'Rehber Bilgileri',
      'choose_guide':
          'Öğrenme yolculuğunuzda size rehberlik edecek kişiyi seçin',
      'female_teacher': 'Kadın Öğretmen',
      'female': 'Kadın',
      'male_teacher': 'Erkek Öğretmen',
      'male': 'Erkek',
      'choose_language': 'Dilinizi seçin',
      'choose_dialect': 'Tercih ettiğiniz lehçeyi seçin',
      'dialect_gulf': 'Körfez',
      'dialect_egyptian': 'Mısır',
      'dialect_fusha': 'Fasih Arapça',
      'parents_section': 'Veli Bölümü',
      'select_gender_and_guide': 'Lütfen cinsiyet ve rehber seçin',
      'let_us_start': 'Hadi Başlayalım',

      // Öğretmen Ekranı
      'teacher_greeting_boy':
          "Acoon'a hoş geldin! Okuma şampiyonu olman için bu eğlenceli öğrenme yolculuğunda öğretmenin olacağım!",
      'teacher_greeting_girl':
          "Acoon'a hoş geldin! Okuma şampiyonu olman için bu eğlenceli öğrenme yolculuğunda öğretmenin olacağım!",
      'next': 'İleri',

      // Ana Sayfa (Home)
      'good_morning': 'Günaydın, {name}!',
      'continue_journey': 'Eğitim yolculuğumuza devam edelim',
      'island_letters': 'Harfler Adası',
      'island_diacritics': 'Harekeler Adası',
      'island_long_vowels': 'Uzatma Harfleri Adası',
      'island_words': 'Kelimeler Adası',
      'island_sentences': 'Cümleler ve Kurallar',
      'island_treasure': 'Büyük Hazine',
      'home_speech_boy':
          'Şimdi Harekeler Adası’na\nyelken açma zamanı!\nÜstün, Esre ve Ötreyi öğrenelim.\nHadi gidelim!',
      'home_speech_girl':
          'Şimdi Harekeler Adası’na\nyelken açma zamanı!\nÜstün, Esre ve Ötreyi öğrenelim.\nHadi gidelim!',

      // Harfler Adası ve Dersler
      'letters_island_title': 'Harfler Adası',
      'continue_btn': 'Devam Et',
      'start_btn': 'Başla!',
      'awesome': 'Harika',
      'well_done': 'Tebrikler!',
      'well_done_hero_boy': 'Aferin Sana Şampiyon!',
      'well_done_hero_girl': 'Aferin Sana Şampiyon!',
      'wrong_answer': 'Yanlış cevap, tekrar dene',
      'listening_practice': 'Dinleme Alıştırması',
      'listen_and_choose': 'Dinle ve doğru harfi seç',
      'write_letter': 'Harfi Yaz',
      'learn_letter': 'Harfi Öğren',
      'letter_positions': 'Harf Konumları',
      'clear': 'Temizle',
      'you_earned_coins': '20 altın kazandın',
      'all_letters_completed_title': 'Harika!',
      'all_letters_completed_desc': 'Artık tüm\nharfleri\nbiliyorsun.',
      'lets_start_new_journey': 'Hadi yeni bir\nyolculuğa başlayalım',

      // Abonelikler ve Planlar
      'subscribers_only_title': 'Bu ada yalnızca\naboneler içindir',
      'unlock_all_islands': 'Tüm adaları açmak için şimdi abone olun',
      'subscribe_now': 'Şimdi Abone Ol',
      'back_to_map': 'Haritaya Dön',
      'subscriptions': 'Abonelikler',
      'one_child': '1 Çocuk',
      'two_children': '2 Çocuk',
      'three_children': '3 Çocuk',
      'suitable_for_one': '1 çocuk için uygundur',
      'suitable_for_two': '2 çocuk için uygundur',
      'suitable_for_three': '3 çocuk için uygundur',
      'most_popular': 'En Çok Tercih Edilen',
      'sar': 'SAR',
      'instead_of': 'yerine',
      'proceed_to_payment': 'Ödemeye Geç',
      'important_info': 'Önemli Bilgiler',
      'all_features': 'Tüm özellikler dahil',
      'separate_profiles': 'İki ayrı çocuk profili',
      'separate_tracking': 'Her çocuğu ayrı ayrı takip etme',
      'detailed_reports': 'Her çocuk için ayrıntılı raporlar',
      'best_saving': 'En İyi Fiyat',
      'updated_content': 'Sürekli güncellenen içerik',
      'secure_payment': '%100 Güvenli Ödeme',
    },

    // =========================================================================
    // 4. اردو (ur)
    // =========================================================================
    'ur': {
      // شروعات اور لاگ ان
      'app_title': 'اکون',
      'welcome_back': 'خوش آمدید!',
      'login_subtitle':
          'اپنے ایڈونچر کو جاری رکھنے اور مزید ستارے جمع کرنے کے لیے لاگ ان کریں',
      'login': 'لاگ ان کریں',
      'create_account': 'نیا اکاؤنٹ بنائیں',
      'no_account': 'کیا آپ کا اکاؤنٹ نہیں ہے؟',
      'already_have_account': 'پہلے سے اکاؤنٹ موجود ہے؟',
      'new_registration': 'نیا اندراج',
      'forgot_password': 'کیا آپ پاس ورڈ بھول گئے؟',
      'email': 'ای میل',
      'enter_email': 'ای میل درج کریں',
      'invalid_email': 'غلط ای میل پتہ',
      'password': 'پاس ورڈ',
      'enter_password': 'پاس ورڈ درج کریں',
      'phone': 'فون نمبر',
      'invalid_phone': 'غلط فون نمبر',

      // سائن اپ
      'child_name': 'بچے کا نام',
      'enter_child_name': 'بچے کا نام درج کریں',
      'age': 'عمر',
      'how_old': 'آپ کی عمر کتنی ہے؟',
      'enter_age': 'عمر درج کریں',
      'gender': 'جنس',
      'boy': 'لڑکا',
      'girl': 'لڑکی',
      'guide_info': 'رہنما کی تفصیلات',
      'choose_guide':
          'منتخب کریں کہ کون آپ کے تعلیمی سفر میں رہنمائی کرے گا',
      'female_teacher': 'استانی',
      'female': 'خاتون',
      'male_teacher': 'استاد',
      'male': 'مرد',
      'choose_language': 'اپنی زبان منتخب کریں',
      'choose_dialect': 'پسندیدہ لہجہ منتخب کریں',
      'dialect_gulf': 'خلیجی',
      'dialect_egyptian': 'مصری',
      'dialect_fusha': 'فصیح عربی',
      'parents_section': 'والدین کا سیکشن',
      'select_gender_and_guide': 'براہ کرم جنس اور رہنما منتخب کریں',
      'let_us_start': 'آئیے شروع کریں',

      // اساتذہ
      'teacher_greeting_boy':
          'اکون میں خوش آمدید! میں آپ کے سیکھنے کے سفر میں آپ کا استاد اور مددگار بنوں گا تاکہ آپ پڑھنے کے ہیرو بن سکیں!',
      'teacher_greeting_girl':
          'اکون میں خوش آمدید! میں آپ کے سیکھنے کے سفر میں آپ کی استانی اور مددگار بنوں گی تاکہ آپ پڑھنے کی ہیروئن بن سکیں!',
      'next': 'اگلا',

      // ہوم اسکرین
      'good_morning': 'صبح بخیر، {name}!',
      'continue_journey': 'آئیے اپنا تعلیمی سفر جاری رکھیں',
      'island_letters': 'حروف کا جزیرہ',
      'island_diacritics': 'اعراب کا جزیرہ',
      'island_long_vowels': 'حروف مد کا جزیرہ',
      'island_words': 'الفاظ کا جزیرہ',
      'island_sentences': 'جملے اور قواعد',
      'island_treasure': 'بڑا خزانہ',
      'home_speech_boy':
          'اب اعراب کے جزیرے پر\nروانہ ہونے کا وقت ہے\nزبر، زیر اور پیش سیکھیں!\nآئیے چلیں!',
      'home_speech_girl':
          'اب اعراب کے جزیرے پر\nروانہ ہونے کا وقت ہے\nزبر، زیر اور پیش سیکھیں!\nآئیے چلیں!',

      // حروف اور اسباق
      'letters_island_title': 'حروف کا جزیرہ',
      'continue_btn': 'جاری رکھیں',
      'start_btn': 'شروع کریں',
      'awesome': 'بہترین',
      'well_done': 'شاباش!',
      'well_done_hero_boy': 'شاباش، ہیرو!',
      'well_done_hero_girl': 'شاباش، ہیروئن!',
      'wrong_answer': 'غلط جواب، دوبارہ کوشش کریں',
      'listening_practice': 'سننے کی مشق',
      'listen_and_choose': 'سنیں اور درست حرف منتخب کریں',
      'write_letter': 'حرف لکھیں',
      'learn_letter': 'حرف سیکھیں',
      'letter_positions': 'حرف کی اشکال',
      'clear': 'صاف کریں',
      'you_earned_coins': 'آپ کو 20 سونے کے سکے ملے',
      'all_letters_completed_title': 'شاندار!',
      'all_letters_completed_desc': 'اب آپ تمام\nحروف کو\nجانتے ہیں۔',
      'lets_start_new_journey': 'آئیے ایک نیا\nسفر شروع کریں',

      // سبسکرپشن اور ادائیگی
      'subscribers_only_title': 'یہ جزیرہ صرف\nسبسکرائبرز کے لیے ہے',
      'unlock_all_islands': 'تمام جزیرے کھولنے کے لیے ابھی سبسکرائب کریں',
      'subscribe_now': 'ابھی سبسکرائب کریں',
      'back_to_map': 'نقشے پر واپس جائیں',
      'subscriptions': 'سبسکرپشنز',
      'one_child': '1 بچہ',
      'two_children': '2 بچے',
      'three_children': '3 بچے',
      'suitable_for_one': '1 بچے کے لیے موزوں',
      'suitable_for_two': '2 بچوں کے لیے موزوں',
      'suitable_for_three': '3 بچوں کے لیے موزوں',
      'most_popular': 'سب سے زیادہ مقبول',
      'sar': 'ریال',
      'instead_of': 'کے بجائے',
      'proceed_to_payment': 'ادائیگی جاری رکھیں',
      'important_info': 'اہم معلومات',
      'all_features': 'تمام خصوصیات شامل ہیں',
      'separate_profiles': 'بچوں کے دو الگ پروفائلز',
      'separate_tracking': 'ہر بچے کو الگ الگ فالو کریں',
      'detailed_reports': 'ہر بچے کے لیے تفصیلی رپورٹس',
      'best_saving': 'بہترین بچت',
      'updated_content': 'مسلسل نیا مواد',
      'secure_payment': '100% محفوظ ادائیگی',
    },
  };

  /// استرجاع النص المترجم حسب مفتاح النص ورمز اللغة
  static String get(String key, {String lang = 'ar', Map<String, String>? params}) {
    final langMap = _values[lang] ?? _values['ar']!;
    var text = langMap[key] ?? _values['ar']?[key] ?? key;

    if (params != null && params.isNotEmpty) {
      params.forEach((paramKey, paramValue) {
        text = text.replaceAll('{$paramKey}', paramValue);
      });
    }

    return text;
  }
}
