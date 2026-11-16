import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/feature/island/model/island_model.dart';
import 'package:flutter/material.dart';

/// ويدجت الجزيرة التفاعلية (منطقة لمس شفافة فوق الجزيرة في الخريطة)
class IslandWidget extends StatelessWidget {
  final IslandModel island;
  final VoidCallback onTap;

  const IslandWidget({
    super.key,
    required this.island,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final size = screenWidth * island.size;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: size,
        height: size * 0.85,
        color: Colors.transparent,
      ),
    );
  }
}

/// كبسولة عنوان الجزيرة التفاعلية المتوافقة ديناميكياً مع لغة التطبيق
class IslandTitlePill extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const IslandTitlePill({
    super.key,
    required this.title,
    this.onTap,
  });

  static const _navy = Color(0xFF0D3B66);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4.5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7C2).withOpacity(0.96),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          title,
          textDirection: AppLocale.textDirection,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: _navy,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
