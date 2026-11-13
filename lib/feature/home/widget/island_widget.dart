import 'package:education_children/feature/home/model/island_model.dart';
import 'package:flutter/material.dart';

class IslandWidget extends StatelessWidget {
  final IslandModel island;
  final VoidCallback onTap;

  const IslandWidget({
    super.key,
    required this.island,
    required this.onTap,
  });

  static const _navy = Color(0xFF0D3B66);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * island.size;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width, // الارتفاع بيتحدد من الصورة نفسها
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // الصورة هي اللي بتحدد حجم الـ Stack
            Image.asset(island.image, width: width, fit: BoxFit.fitWidth),

            if (island.locked) const _LockBadge(),

            Positioned(
              bottom: width * island.labelBottom,
              child: _TitlePill(title: island.title, maxWidth: width),
            ),
          ],
        ),
      ),
    );
  }
} // <-- القوس ده اللي كان ناقص

class _LockBadge extends StatelessWidget {
  const _LockBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade700.withOpacity(.9),
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.25),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Icon(Icons.lock_outline, color: Colors.white, size: 28),
    );
  }
}

class _TitlePill extends StatelessWidget {
  final String title;
  final double maxWidth;

  const _TitlePill({required this.title, required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth * 0.95),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3B0).withOpacity(.75),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withOpacity(.7), width: 1.5),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: IslandWidget._navy,
            ),
          ),
        ),
      ),
    );
  }
}