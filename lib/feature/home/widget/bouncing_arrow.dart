import 'package:flutter/material.dart';

/// السهم الأصفر العريض المتحرك للأعلى والأسفل (مطابق تماماً لتصميم Figma)
class BouncingArrow extends StatefulWidget {
  final double width;
  final double height;
  final Color color;

  const BouncingArrow({
    super.key,
    this.width = 46,
    this.height = 72,
    this.color = const Color(0xFFFFCC00),
  });

  @override
  State<BouncingArrow> createState() => _BouncingArrowState();
}

class _BouncingArrowState extends State<BouncingArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _anim.value),
        child: child,
      ),
      child: CustomPaint(
        size: Size(widget.width, widget.height),
        painter: _ChunkyArrowPainter(color: widget.color),
      ),
    );
  }
}

class _ChunkyArrowPainter extends CustomPainter {
  final Color color;

  const _ChunkyArrowPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final stemW = w * 0.48;
    final stemLeft = (w - stemW) / 2;
    final stemRight = stemLeft + stemW;
    final headTop = h * 0.58;

    final path = Path()
      ..moveTo(stemLeft + 5, 0)
      ..lineTo(stemRight - 5, 0)
      ..quadraticBezierTo(stemRight, 0, stemRight, 5)
      ..lineTo(stemRight, headTop)
      ..lineTo(w - 4, headTop)
      ..quadraticBezierTo(w, headTop, w - 2, headTop + 4)
      ..lineTo(w / 2 + 3, h - 3)
      ..quadraticBezierTo(w / 2, h, w / 2 - 3, h - 3)
      ..lineTo(2, headTop + 4)
      ..quadraticBezierTo(0, headTop, 4, headTop)
      ..lineTo(stemLeft, headTop)
      ..lineTo(stemLeft, 5)
      ..quadraticBezierTo(stemLeft, 0, stemLeft + 5, 0)
      ..close();

    // Drop shadow
    canvas.drawShadow(path, const Color(0x40000000), 5.0, true);

    // Arrow fill
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ChunkyArrowPainter oldDelegate) =>
      oldDelegate.color != color;
}
