import 'package:education_children/feature/home/model/island_model.dart';
import 'package:flutter/material.dart';

class DashedPathPainter extends CustomPainter {
  final List<IslandModel> islands;

  const DashedPathPainter(this.islands);

  @override
  void paint(Canvas canvas, Size size) {
    if (islands.length < 2) return;

    final pts = islands
        .map((i) => Offset(i.x * size.width, i.y * size.height))
        .toList();

    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 0; i < pts.length - 1; i++) {
      final a = pts[i];
      final b = pts[i + 1];
      final midY = (a.dy + b.dy) / 2;
      path.cubicTo(a.dx, midY, b.dx, midY, b.dx, b.dy);
    }

    final paint = Paint()
      ..color = Colors.white.withOpacity(.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    const dashLength = 12.0;
    const gapLength = 10.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashLength),
          paint,
        );
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant DashedPathPainter oldDelegate) =>
      oldDelegate.islands != islands;
}