import 'package:flutter/material.dart';

class SubColors {
  static const navy = Color(0xFF0B0B6B);
  static const yellow = Color(0xFFFFC21F);
}

class SubscriptionTopBar extends StatelessWidget {
  final String title;
  const SubscriptionTopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          const SizedBox(width: 34),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: SubColors.navy,
              ),
            ),
          ),
          // Close button (left side in RTL)
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close_rounded,
                  size: 18, color: SubColors.navy),
            ),
          ),
        ],
      ),
    );
  }
}

class NavyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const NavyButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: SubColors.navy,
          foregroundColor: Colors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}