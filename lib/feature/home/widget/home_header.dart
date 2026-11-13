import 'package:education_children/core/style/app_assets.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  final int coins;
  final int stars;
  final VoidCallback? onAddCoins;
  final VoidCallback? onAddStars;

  const HomeHeader({
    super.key,
    required this.name,
    required this.coins,
    required this.stars,
    this.onAddCoins,
    this.onAddStars,
  });

  static const _navy = Color(0xFF0D3B66);

  @override
  Widget build(BuildContext context) {
    // The Row is LTR on purpose: avatar (left) - greeting - chips (right)
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage(AppAssets.user),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'صباح الخير يا $name !',
                    textDirection: TextDirection.rtl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _navy,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'هيا نكمل رحلتنا التعليمية',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 13, color: _navy),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                _StatChip(
                  icon: Icons.monetization_on,
                  color: Colors.amber,
                  value: coins,
                  onAdd: onAddCoins,
                ),
                const SizedBox(height: 8),
                _StatChip(
                  icon: Icons.star,
                  color: const Color(0xFFFFD400),
                  value: stars,
                  onAdd: onAddStars,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final int value;
  final VoidCallback? onAdd;

  const _StatChip({
    required this.icon,
    required this.color,
    required this.value,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF0D4C8B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.lightBlueAccent, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 6),
          Text(
            '$value',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onAdd,
            child: const Icon(Icons.add, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}