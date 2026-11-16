import 'dart:math';
import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/state/user_profile_state.dart';
import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/feature/auth/signup/sign_up_option.dart';
import 'package:education_children/feature/home/widget/bouncing_arrow.dart';
import 'package:education_children/feature/home/widget/home_header.dart';
import 'package:education_children/feature/home/widget/island_widget.dart';
import 'package:education_children/feature/island/letters_island_screen.dart';
import 'package:education_children/feature/island/model/island_model.dart';
import 'package:education_children/feature/island/plans_screen.dart';
import 'package:education_children/feature/island/subscribe_dialog.dart';
import 'package:flutter/material.dart';

/// الشاشة الرئيسية التفاعلية (خريطة الجزر كاملة مع إمكانية التمرير/السكرول)
class HomeScreen extends StatefulWidget {
  final String name;
  final bool? lettersCompleted;
  final Gender? gender;

  const HomeScreen({
    super.key,
    this.name = 'عمر',
    this.lettersCompleted,
    this.gender,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _lettersCompleted;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _lettersCompleted = widget.lettersCompleted ?? false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onIslandTap(IslandModel island) async {
    if (island.locked) {
      // شاشة الاشتراك للمشتركين فقط
      final shouldSubscribe = await showSubscribersOnlyDialog(context);
      if (shouldSubscribe == true && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PlansScreen()),
        );
      }
      return;
    }

    if (island.titleKey == 'island_letters' || island.title == 'جزيرة الحروف') {
      final isGirl = (widget.gender == Gender.girl) || UserProfile.isGirl;
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/letters_island'),
          builder: (_) => LettersIslandScreen(allCompleted: _lettersCompleted),
        ),
      );
      if (result == true && mounted) {
        setState(() => _lettersCompleted = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isGirl = (widget.gender == Gender.girl) || UserProfile.isGirl;
    final defaultName = isGirl ? 'سارة' : 'عمر';
    final displayName =
        (widget.name.trim().isEmpty || (widget.name == 'عمر' && isGirl))
        ? (UserProfile.name.value.isNotEmpty
              ? UserProfile.name.value
              : defaultName)
        : widget.name;

    final coins = _lettersCompleted ? 250 : 100;
    final stars = _lettersCompleted ? 78 : 0;
    final activeIsland = _lettersCompleted && islands.length > 1
        ? islands[1] // جزيرة الحركات
        : islands.first; // جزيرة الحروف

    final speechText = isGirl
        ? 'home_speech_girl'.tr()
        : 'home_speech_boy'.tr();

    final kidStandingAsset = isGirl
        ? AppAssets.girlStanding
        : AppAssets.kidStanding;

    return Scaffold(
      backgroundColor: const Color(0xFF1E88E5),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          // نسبة الأبعاد الأصلية لصورة الخريطة 393 × 956 لضمان دقة مواضع كل الجزر
          final baseMapHeight = screenWidth * (956.0 / 393.0);
          final extraBottom = _lettersCompleted ? 150.0 : 40.0;
          final totalMapHeight =
              max(constraints.maxHeight, baseMapHeight) + extraBottom;

          return Stack(
            children: [
              // ==========================================================
              // 1. خريطة الجزر كاملة قابلة للتمرير الرأسي (Scrollable Map)
              // ==========================================================
              Positioned.fill(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    width: screenWidth,
                    height: totalMapHeight,
                    child: Stack(
                      children: [
                        // أ) خريطة الجزر كاملة من التصميم الأصلي
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: totalMapHeight,
                          child: Image.asset(
                            AppAssets.backgroundHome,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),

                        // ب) مناطق اللمس التفاعلية فوق كل جزيرة
                        for (final island in islands)
                          Positioned(
                            left:
                                island.x * screenWidth -
                                (screenWidth * island.size) / 2,
                            top:
                                island.y * baseMapHeight -
                                (screenWidth * island.size) / 2,
                            child: IslandWidget(
                              island: island,
                              onTap: () => _onIslandTap(island),
                            ),
                          ),

                        // ج) كبسولات أسماء الجزر التفاعلية المتوافقة مع لغة التطبيق
                        for (final island in islands)
                          Positioned(
                            left: island.pillX * screenWidth - 90,
                            top: island.pillY * baseMapHeight - 16,
                            width: 180,
                            child: Center(
                              child: IslandTitlePill(
                                title: island.displayTitle,
                                onTap: () => _onIslandTap(island),
                              ),
                            ),
                          ),

                        // د) السهم الأصفر المتحرك يشير بدقة تامة إلى الجزيرة الحالية
                        Positioned(
                          left: activeIsland.arrowX * screenWidth - 23,
                          top: activeIsland.arrowY * baseMapHeight - 36,
                          child: const BouncingArrow(width: 46, height: 72),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ==========================================================
              // 2. الهيدر العلوي ثابت أثناء السكرول (النقاط، النجوم، الأفاتار)
              // ==========================================================
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  bottom: false,
                  child: Directionality(
                    textDirection: AppLocale.textDirection,
                    child: HomeHeader(
                      name: displayName,
                      gender: isGirl ? Gender.girl : Gender.boy,
                      coins: coins,
                      stars: stars,
                      // إمكانية التبديل بالنقر على عداد النقاط للمعاينة الفورية
                      onAddCoins: () => setState(
                        () => _lettersCompleted = !_lettersCompleted,
                      ),
                    ),
                  ),
                ),
              ),

              // ==========================================================
              // 3. لافتة التوجيه السفلية مع الطفل المتكلم (عند اكتمال الحروف)
              // ==========================================================
              if (_lettersCompleted)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: HomeSpeechBanner(
                    speechText: speechText,
                    characterAsset: kidStandingAsset,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

// ============================================================================
// ويدجت لافتة التوجيه السفلية مع الطفل المتكلم (ولد أو بنت)
// ============================================================================
class HomeSpeechBanner extends StatelessWidget {
  final String speechText;
  final String characterAsset;

  const HomeSpeechBanner({
    super.key,
    required this.speechText,
    required this.characterAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomLeft,
        children: [
          // كارت الكلام الأزرق الفاتح
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            padding: const EdgeInsets.fromLTRB(140, 16, 18, 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFE2F0F9).withOpacity(0.93),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              speechText,
              textAlign: AppLocale.isRtl ? TextAlign.right : TextAlign.left,
              textDirection: AppLocale.textDirection,
              style: const TextStyle(
                fontSize: 18,
                height: 1.35,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D3B66),
              ),
            ),
          ),

          // صورة الطفل واقفاً على اليسار (بنت أو ولد)
          Positioned(
            left: 10,
            bottom: 0,
            child: Image.asset(
              characterAsset,
              height: 190,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
