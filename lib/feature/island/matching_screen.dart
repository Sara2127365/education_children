import 'package:education_children/feature/island/widget/lesson_widget.dart';
import 'package:education_children/feature/island/widget/lesson_widgets.dart' hide LessonScaffold, LessonColors;
import 'package:flutter/material.dart';


class MatchItem {
  final String letter;
  final String imageAsset;
  const MatchItem({required this.letter, required this.imageAsset});
}

/// شاشة "توصيل" - صل الحرف بالصورة المناسبة
class MatchingScreen extends StatefulWidget {
  final VoidCallback onContinue;
  const MatchingScreen({super.key, required this.onContinue});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  // الصور (يمين) بالترتيب: تفاحة، بيت، أرنب
  static const _images = [
    MatchItem(letter: 'ت', imageAsset: 'assets/images/apple.png'),
    MatchItem(letter: 'ب', imageAsset: 'assets/images/house.png'),
    MatchItem(letter: 'أ', imageAsset: 'assets/images/rabbit.png'),
  ];
  // الحروف (يسار) بالترتيب: ب، ت، أ
  static const _letters = ['ب', 'ت', 'أ'];

  final _stackKey = GlobalKey();
  final _imageKeys = List.generate(3, (_) => GlobalKey());
  final _letterKeys = List.generate(3, (_) => GlobalKey());

  final Map<int, int> _links = {}; // imageIndex -> letterIndex
  int? _dragFrom;
  Offset? _dragStart;
  Offset? _dragCurrent;

  bool get _done =>
      _links.length == 3 &&
      _links.entries.every((e) => _letters[e.value] == _images[e.key].letter);

  Rect _rectOf(GlobalKey key) {
    final box = key.currentContext!.findRenderObject() as RenderBox;
    final stackBox = _stackKey.currentContext!.findRenderObject() as RenderBox;
    final topLeft = stackBox.globalToLocal(box.localToGlobal(Offset.zero));
    return topLeft & box.size;
  }

  int? _hitTest(List<GlobalKey> keys, Offset p) {
    for (int i = 0; i < keys.length; i++) {
      if (_rectOf(keys[i]).contains(p)) return i;
    }
    return null;
  }

  void _onStart(DragStartDetails d) {
    if (_done) return;
    final p = d.localPosition;
    final i = _hitTest(_imageKeys, p);
    if (i == null) return;
    setState(() {
      _dragFrom = i;
      _dragStart = _rectOf(_imageKeys[i]).centerLeft;
      _dragCurrent = p;
      _links.remove(i);
    });
  }

  void _onUpdate(DragUpdateDetails d) {
    if (_dragFrom == null) return;
    setState(() => _dragCurrent = d.localPosition);
  }

  void _onEnd(DragEndDetails d) {
    if (_dragFrom == null || _dragCurrent == null) return;
    final j = _hitTest(_letterKeys, _dragCurrent!);
    setState(() {
      if (j != null) {
        // نمنع وصلتين لنفس الحرف
        _links.removeWhere((_, letter) => letter == j);
        _links[_dragFrom!] = j;
      }
      _dragFrom = null;
      _dragStart = null;
      _dragCurrent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LessonScaffold(
      title: 'توصيل',
      subtitle: 'صل الحرف بالصورة المناسبة',
      bottom: _done
          ? MascotPanel(
              mascotAsset: 'assets/images/mascot_success.png',
              message: 'أحسنت\nأيها البطل',
              onContinue: widget.onContinue,
            )
          : const SizedBox(height: 230),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(26, 24, 26, 0),
        child: GestureDetector(
          onPanStart: _onStart,
          onPanUpdate: _onUpdate,
          onPanEnd: _onEnd,
          child: Stack(
            key: _stackKey,
            children: [
              // الخطوط تحت الصناديق
              Positioned.fill(
                child: CustomPaint(painter: _LinesPainter(_buildLines())),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // يمين: الصور
                    Column(
                      children: [
                        for (int i = 0; i < 3; i++)
                          _Box(
                            key: _imageKeys[i],
                            child: Image.asset(_images[i].imageAsset, height: 70),
                          ),
                      ],
                    ),
                    // يسار: الحروف
                    Column(
                      children: [
                        for (int i = 0; i < 3; i++)
                          _Box(
                            key: _letterKeys[i],
                            child: Text(
                              _letters[i],
                              style: TextStyle(
                                fontSize: 56,
                                color: LessonColors.navy,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<List<Offset>> _buildLines() {
    // نحسب الخطوط بعد أول فريم عشان الـ keys تكون جاهزة
    if (_imageKeys.any((k) => k.currentContext == null) ||
        _letterKeys.any((k) => k.currentContext == null)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
      return [];
    }
    final lines = <List<Offset>>[];
    _links.forEach((i, j) {
      lines.add([
        _rectOf(_imageKeys[i]).centerLeft,
        _rectOf(_letterKeys[j]).centerRight,
      ]);
    });
    if (_dragStart != null && _dragCurrent != null) {
      lines.add([_dragStart!, _dragCurrent!]);
    }
    return lines;
  }
}

class _Box extends StatelessWidget {
  final Widget child;
  const _Box({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152,
      height: 98,
      margin: const EdgeInsets.only(bottom: 36),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: LessonColors.navy),
      ),
      child: child,
    );
  }
}

class _LinesPainter extends CustomPainter {
  final List<List<Offset>> lines;
  _LinesPainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    for (final l in lines) {
      canvas.drawLine(l.first, l.last, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LinesPainter old) => true;
}