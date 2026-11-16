import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/state/learning_state.dart';
import 'package:education_children/core/state/user_profile_state.dart';
import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/feature/home/home_screen.dart';
import 'package:education_children/feature/island/learn_letter_screen.dart';
import 'package:education_children/feature/island/widget/lesson_widgets.dart';
import 'package:education_children/feature/island/model/letter_model.dart';
import 'package:flutter/material.dart';

class LettersIslandScreen extends StatefulWidget {
  final bool allCompleted;
  const LettersIslandScreen({super.key, this.allCompleted = false});

  @override
  State<LettersIslandScreen> createState() => _LettersIslandScreenState();
}

class _LettersIslandScreenState extends State<LettersIslandScreen> {
  int _completionStep = 0; // 0 = المعلم يهنئ، 1 = الطفل وزر انطلق

  @override
  void initState() {
    super.initState();
    if (widget.allCompleted) {
      LearningProgress.completedLetters.value =
          List.generate(arabicLetters.length, (i) => i).toSet();
    }
  }

  void _startLesson(int index) {
    LearningProgress.selectedIndex.value = index;
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: const RouteSettings(name: '/lesson'),
        builder: (_) => LearnLetterScreen(letter: arabicLetters[index]),
      ),
    );
  }

  Widget _buildCompletionBottom() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: 195,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _completionStep == 0
            ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() => _completionStep = 1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // المعلم المصفق على اليسار
                    Image.asset(
                      AppAssets.manTeacher,
                      height: 185,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 8),
                    // عبارة التهنئة على اليمين
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24, right: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: AppLocale.isRtl
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.translate(
                                  offset: const Offset(0, -2),
                                  child: const Text('✨',
                                      style: TextStyle(fontSize: 22)),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'all_letters_completed_title'.tr(),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: LessonColors.navy,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'all_letters_completed_desc'.tr(),
                              textAlign: AppLocale.isRtl
                                  ? TextAlign.right
                                  : TextAlign.left,
                              textDirection: AppLocale.textDirection,
                              style: const TextStyle(
                                fontSize: 24,
                                height: 1.25,
                                fontWeight: FontWeight.bold,
                                color: LessonColors.navy,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // الطفل يركض أو يقف على اليسار (بنت أو ولد)
                  Image.asset(
                    UserProfile.isGirl
                        ? AppAssets.girlStanding
                        : AppAssets.kidRunning,
                    height: 175,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  // هيا بنا نبدأ رحلة جديدة + زر انطلق
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'lets_start_new_journey'.tr(),
                            textAlign: TextAlign.center,
                            textDirection: AppLocale.textDirection,
                            style: const TextStyle(
                              fontSize: 24,
                              height: 1.3,
                              fontWeight: FontWeight.bold,
                              color: LessonColors.navy,
                            ),
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: 145,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context, true);
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      settings: const RouteSettings(
                                          name: '/home_screen'),
                                      builder: (_) => HomeScreen(
                                        name: UserProfile.name.value,
                                        gender: UserProfile.gender.value,
                                        lettersCompleted: true,
                                      ),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF070068),
                                foregroundColor: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Text(
                                'start_btn'.tr(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        LearningProgress.completedLetters,
        LearningProgress.selectedIndex,
      ]),
      builder: (context, _) {
        final completed = LearningProgress.completedLetters.value;
        final selected = LearningProgress.selectedIndex.value;
        final isAllDone = completed.length == arabicLetters.length;

        return LessonScaffold(
          title: 'letters_island_title'.tr(),
          showBack: false,
          buttonText: isAllDone ? null : 'continue_btn'.tr(),
          onButtonPressed: isAllDone ? null : () => _startLesson(selected),
          bottom: isAllDone ? _buildCompletionBottom() : null,
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            itemCount: arabicLetters.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.02,
            ),
            itemBuilder: (_, i) => _LetterTile(
              letter: arabicLetters[i].letter,
              completed: completed.contains(i),
              selected: i == selected,
              onTap: () {
                if (isAllDone) {
                  setState(() => _completionStep = (_completionStep + 1) % 2);
                } else {
                  // فتح درس الحرف مباشرة عند الضغط عليه أو اختياره
                  _startLesson(i);
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class _LetterTile extends StatelessWidget {
  final String letter;
  final bool completed;
  final bool selected;
  final VoidCallback onTap;

  const _LetterTile({
    required this.letter,
    required this.completed,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = LessonColors.card;
    Color? border;
    if (completed) {
      bg = const Color(0xFFAEDDB0);
      border = const Color(0xFF3E9E45);
    } else if (selected) {
      bg = const Color(0xFFADCBDB);
      border = LessonColors.navy;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: border == null ? null : Border.all(color: border, width: 2),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                letter,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: LessonColors.navy,
                ),
              ),
            ),
            if (completed)
              const Positioned(
                top: 8,
                left: 8,
                child: CircleAvatar(
                  radius: 11,
                  backgroundColor: Color(0xFF2E9A3D),
                  child: Icon(Icons.check, size: 14, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
