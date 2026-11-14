import 'package:education_children/feature/island/widget/lesson_widget.dart';
import 'package:flutter/material.dart';


/// شاشة "اكتب" - تتبع الحرف بالنقاط
class WriteLetterScreen extends StatefulWidget {
  final String letterName; // مثال: الباء
  final VoidCallback onContinue;

  const WriteLetterScreen({
    super.key,
    this.letterName = 'الباء',
    required this.onContinue,
  });

  @override
  State<WriteLetterScreen> createState() => _WriteLetterScreenState();
}

class _WriteLetterScreenState extends State<WriteLetterScreen> {
  // مواقع النقاط كنسبة من حجم البطاقة (0..1) - آخر نقطة هي نقطة الباء
  static const List<Offset> _dots = [
    Offset(.206, .391),
    Offset(.214, .483),
    Offset(.249, .571),
    Offset(.314, .637),
    Offset(.403, .671),
    Offset(.500, .683),
    Offset(.591, .671),
    Offset(.683, .637),
    Offset(.749, .571),
    Offset(.783, .483),
    Offset(.794, .391),
    Offset(.500, .829), // نقطة تحت الحرف
  ];

  final List<List<Offset>> _strokes = [];
  final Set<int> _hit = {};
  Size _size = Size.zero;

  bool get _done => _hit.length == _dots.length;

  void _checkHits(Offset p) {
    for (int i = 0; i < _dots.length; i++) {
      final center = Offset(_dots[i].dx * _size.width, _dots[i].dy * _size.height);
      if ((center - p).distance < 24) _hit.add(i);
    }
  }

  void _start(Offset p) {
    if (_done) return;
    setState(() {
      _strokes.add([p]);
      _checkHits(p);
    });
  }

  void _update(Offset p) {
    if (_done) return;
    setState(() {
      _strokes.last.add(p);
      _checkHits(p);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LessonScaffold(
      title: 'اكتب',
      subtitle: _done ? null : 'تتبع الحرف بالنقاط',
      bottom: _done
          ? MascotPanel(
              mascotAsset: 'assets/images/mascot_success.png',
              message: 'أحسنت\nأيها البطل',
              onContinue: widget.onContinue,
            )
          : MascotPanel(
              mascotAsset: 'assets/images/mascot_thinking.png',
              message: 'قم بتتبع النقاط لكتابة\nحرف ${widget.letterName}',
            ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 24, 22, 0),
        child: AspectRatio(
          aspectRatio: 1,
          child: WhiteCard(
            child: LayoutBuilder(
              builder: (context, c) {
                _size = Size(c.maxWidth, c.maxHeight);
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanStart: (d) => _start(d.localPosition),
                  onPanUpdate: (d) => _update(d.localPosition),
                  onTapDown: (d) => _start(d.localPosition),
                  child: CustomPaint(
                    size: _size,
                    painter: _TracePainter(
                      dots: _dots,
                      hit: _hit,
                      strokes: _strokes,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _TracePainter extends CustomPainter {
  final List<Offset> dots;
  final Set<int> hit;
  final List<List<Offset>> strokes;

  _TracePainter({required this.dots, required this.hit, required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()..color = LessonColors.dot;
    for (int i = 0; i < dots.length; i++) {
      final center = Offset(dots[i].dx * size.width, dots[i].dy * size.height);
      final isLast = i == dots.length - 1;
      canvas.drawCircle(center, isLast ? 14 : 11, dotPaint);
    }

    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (final s in strokes) {
      if (s.length == 1) {
        canvas.drawCircle(s.first, 2, Paint()..color = Colors.black);
        continue;
      }
      final path = Path()..moveTo(s.first.dx, s.first.dy);
      for (final p in s.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(path, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TracePainter old) => true;
}