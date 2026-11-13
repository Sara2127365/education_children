import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/feature/auth/widgets/auth_backgroud.dart';
import 'package:education_children/feature/home/model/island_model.dart';
import 'package:education_children/feature/home/widget/dashed_path_painter.dart';
import 'package:education_children/feature/home/widget/home_header.dart';
import 'package:education_children/feature/home/widget/island_widget.dart';
import 'package:education_children/feature/letters/letters_island_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
   final String name;
  const HomeScreen({super.key, required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _arrowCtrl;
  late final Animation<double> _arrowAnim;

  @override
  void initState() {
    super.initState();
    _arrowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _arrowAnim = Tween<double>(begin: 0, end: 14).animate(
      CurvedAnimation(parent: _arrowCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _arrowCtrl.dispose();
    super.dispose();
  }

  void _onIslandTap(IslandModel island) {
    if (island.locked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أكمل الجزيرة السابقة أولاً 🔒')),
      );
      return;
    }
    if (island.title == 'جزيرة الحروف') {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const LettersIslandScreen()),
  );
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        imagePath: AppAssets.backgroundHome,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;
              final h = c.maxHeight;

              return Stack(
                children: [
                  // الخط المنقط
                  Positioned.fill(
                    child: CustomPaint(painter: DashedPathPainter(islands)),
                  ),

                  // الجزر
                  for (final island in islands)
                    Positioned(
                      left: island.x * w - (w * island.size) / 2,
                      top: island.y * h - (w * island.size) / 2,
                      child: IslandWidget(
                        island: island,
                        onTap: () => _onIslandTap(island),
                      ),
                    ),

                  // السهم الأصفر فوق أول جزيرة
                  Positioned(
                    left: islands.first.x * w - 30,
                    top: islands.first.y * h - (w * islands.first.size) / 2 - 70,
                    child: AnimatedBuilder(
                      animation: _arrowAnim,
                      builder: (_, child) => Transform.translate(
                        offset: Offset(0, _arrowAnim.value),
                        child: child,
                      ),
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        size: 60,
                        color: Color(0xFFFFD400),
                      ),
                    ),
                  ),

                  // الهيدر
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: HomeHeader(name: widget.name, coins: 100, stars: 0),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}