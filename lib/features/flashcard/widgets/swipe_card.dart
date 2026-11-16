import 'package:flutter/material.dart';

enum SwipeDirection { left, right }

/// Thẻ kéo được sang trái/phải. Kéo quá [threshold] (tỉ lệ bề ngang) thì
/// thẻ bay ra và gọi [onSwiped]; chưa đủ thì bật về chỗ cũ.
class SwipeCard extends StatefulWidget {
  const SwipeCard({
    super.key,
    required this.child,
    required this.onSwiped,
    this.leftLabel,
    this.rightLabel,
    this.leftColor = Colors.red,
    this.rightColor = Colors.green,
    this.threshold = 0.28,
    this.enabled = true,
  });

  final Widget child;
  final ValueChanged<SwipeDirection> onSwiped;
  final String? leftLabel;
  final String? rightLabel;
  final Color leftColor;
  final Color rightColor;
  final double threshold;
  final bool enabled;

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  );
  double _dx = 0;
  Animation<double>? _tween;

  @override
  void initState() {
    super.initState();
    _anim.addListener(() => setState(() => _dx = _tween!.value));
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _animateTo(double target, {VoidCallback? then}) {
    _tween = Tween(begin: _dx, end: target)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _anim.forward(from: 0).then((_) => then?.call());
  }

  void _onEnd(double width) {
    if (_dx.abs() > width * widget.threshold) {
      final dir = _dx > 0 ? SwipeDirection.right : SwipeDirection.left;
      _animateTo(_dx.sign * width * 1.5, then: () => widget.onSwiped(dir));
    } else {
      _animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      final width = box.maxWidth;
      final progress = (_dx / (width * widget.threshold)).clamp(-1.0, 1.0);
      final label = progress > 0 ? widget.rightLabel : widget.leftLabel;
      final color = progress > 0 ? widget.rightColor : widget.leftColor;

      return GestureDetector(
        onHorizontalDragUpdate: widget.enabled
            ? (d) => setState(() => _dx += d.delta.dx)
            : null,
        onHorizontalDragEnd: widget.enabled ? (_) => _onEnd(width) : null,
        child: Transform.translate(
          offset: Offset(_dx, 0),
          child: Transform.rotate(
            angle: _dx / width * 0.25,
            child: Stack(
              children: [
                widget.child,
                if (label != null && progress.abs() > 0.05)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12 * progress.abs()),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: color.withValues(alpha: progress.abs()),
                            width: 3,
                          ),
                        ),
                        child: Align(
                          alignment: progress > 0
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Opacity(
                              opacity: progress.abs(),
                              child: Text(
                                label,
                                style: TextStyle(
                                  color: color,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
