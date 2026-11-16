import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/state/learning_state.dart';
import 'package:education_children/core/state/user_profile_state.dart';
import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/feature/home/home_screen.dart';
import 'package:education_children/feature/island/cubit/letters_cubit.dart';
import 'package:education_children/feature/island/cubit/letters_state.dart';
import 'package:education_children/feature/island/learn_letter_screen.dart';
import 'package:education_children/feature/island/model/letter_model.dart';
import 'package:education_children/feature/island/widget/lesson_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LettersIslandScreen extends StatelessWidget {
  final bool allCompleted;
  const LettersIslandScreen({super.key, this.allCompleted = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LettersCubit()..fetchLetters(),
      child: _LettersIslandContent(allCompleted: allCompleted),
    );
  }
}

class _LettersIslandContent extends StatefulWidget {
  final bool allCompleted;
  const _LettersIslandContent({this.allCompleted = false});

  @override
  State<_LettersIslandContent> createState() => _LettersIslandContentState();
}

class _LettersIslandContentState extends State<_LettersIslandContent> {
  int _completionStep = 0; // 0 = المعلم يهنئ، 1 = الطفل وزر انطلق

  @override
  void initState() {
    super.initState();
    if (widget.allCompleted) {
      LearningProgress.completedLetters.value =
          List.generate(arabicLetters.length, (i) => i).toSet();
    }
  }

  void _startLesson(int index) async {
    LearningProgress.selectedIndex.value = index;
    final cubit = context.read<LettersCubit>();

    await Navigator.push(
      context,
      MaterialPageRoute(
        settings: const RouteSettings(name: '/lesson'),
        builder: (_) => LearnLetterScreen(letter: arabicLetters[index]),
      ),
    );

    if (mounted) {
      cubit.fetchLetters();
    }
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
                    Image.asset(
                      AppAssets.manTeacher,
                      height: 185,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 8),
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
                                color: Color(0xFF4A6B82),
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
                  Image.asset(
                    AppAssets.kidRunning,
                    height: 195,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24, right: 8),
                      child: SizedBox(
                        height: 58,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                settings:
                                    const RouteSettings(name: '/home_screen'),
                                builder: (_) => HomeScreen(
                                  name: UserProfile.name.value,
                                  gender: UserProfile.gender.value,
                                  lettersCompleted: true,
                                ),
                              ),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF9A825),
                            foregroundColor: LessonColors.navy,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'lets_go_btn'.tr(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: LessonColors.navy,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: LessonColors.navy,
                                size: 26,
                              ),
                            ],
                          ),
                        ),
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
    return BlocConsumer<LettersCubit, LettersState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<CharacterItemUiModel> lettersList = [];
        Set<int> completedSet = LearningProgress.completedLetters.value;
        int selectedIndex = LearningProgress.selectedIndex.value;
        bool isAllDone = false;
        bool isLoading = state is LettersLoadingState;

        if (state is LettersSuccessState) {
          lettersList = state.letters;
          completedSet = state.completedIndexes;
          selectedIndex = state.selectedIndex;
          isAllDone = state.allCompleted;
        } else if (state is LettersErrorState) {
          lettersList = state.fallbackLetters;
          isAllDone = completedSet.length == arabicLetters.length;
        } else {
          // حالة ابتدائية
          lettersList = List.generate(
            arabicLetters.length,
            (i) => CharacterItemUiModel(
              index: i,
              characterId: i + 1,
              letter: arabicLetters[i].letter,
              name: arabicLetters[i].letter,
              isUnlocked: i == 0 || completedSet.contains(i - 1),
              isCompleted: completedSet.contains(i),
              starsCount: completedSet.contains(i) ? 3 : 0,
              localModel: arabicLetters[i],
            ),
          );
          isAllDone = completedSet.length == arabicLetters.length;
        }

        return Stack(
          children: [
            LessonScaffold(
              title: 'letters_island_title'.tr(),
              showBack: false,
              buttonText: isAllDone ? null : 'continue_btn'.tr(),
              onButtonPressed: isAllDone ? null : () => _startLesson(selectedIndex),
              bottom: isAllDone ? _buildCompletionBottom() : null,
              child: RefreshIndicator(
                color: const Color(0xFFFFD400),
                onRefresh: () => context.read<LettersCubit>().fetchLetters(),
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  itemCount: lettersList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.02,
                  ),
                  itemBuilder: (_, i) {
                    final item = lettersList[i];
                    return _LetterTile(
                      letter: item.letter,
                      completed: item.isCompleted,
                      selected: i == selectedIndex,
                      locked: !item.isUnlocked,
                      starsCount: item.starsCount,
                      onTap: () {
                        if (isAllDone) {
                          setState(
                              () => _completionStep = (_completionStep + 1) % 2);
                        } else if (!item.isUnlocked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('أكمل الحروف السابقة أولاً يا بطل! 🌟'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        } else {
                          context.read<LettersCubit>().selectLetter(i);
                          _startLesson(i);
                        }
                      },
                    );
                  },
                ),
              ),
            ),

            if (isLoading)
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  bottom: false,
                  child: LinearProgressIndicator(
                    minHeight: 3,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD400)),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _LetterTile extends StatelessWidget {
  final String letter;
  final bool completed;
  final bool selected;
  final bool locked;
  final int starsCount;
  final VoidCallback onTap;

  const _LetterTile({
    required this.letter,
    required this.completed,
    required this.selected,
    this.locked = false,
    this.starsCount = 0,
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
    } else if (locked) {
      bg = Colors.grey.shade200;
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
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: locked ? Colors.grey.shade400 : LessonColors.navy,
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
            if (locked && !completed)
              Positioned(
                top: 8,
                left: 8,
                child: CircleAvatar(
                  radius: 11,
                  backgroundColor: Colors.grey.shade400,
                  child: const Icon(Icons.lock, size: 12, color: Colors.white),
                ),
              ),
            if (starsCount > 0 && !locked)
              Positioned(
                bottom: 6,
                right: 8,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    starsCount.clamp(1, 3),
                    (_) => const Icon(Icons.star, size: 12, color: Color(0xFFFFB300)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
