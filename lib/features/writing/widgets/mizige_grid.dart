import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Ô 米字格: viền vuông, hai đường giữa và hai đường chéo nét đứt — khung
/// chuẩn để tập viết chữ Hán cân đối.
class MizigeGrid extends StatelessWidget {
  const MizigeGrid({super.key, this.child, this.color});

  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary.withValues(alpha: 0.35);
    return CustomPaint(painter: _MizigePainter(c), child: child);
  }
}

class _MizigePainter extends CustomPainter {
  _MizigePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final border = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(Offset.zero & size, border);

    final dashed = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (final (a, b) in [
      (Offset(w / 2, 0), Offset(w / 2, h)),
      (Offset(0, h / 2), Offset(w, h / 2)),
      (Offset.zero, Offset(w, h)),
      (Offset(w, 0), Offset(0, h)),
    ]) {
      _dash(canvas, a, b, dashed);
    }
  }

  void _dash(Canvas canvas, Offset a, Offset b, Paint paint) {
    const dash = 6.0, gap = 5.0;
    final total = (b - a).distance;
    final dir = (b - a) / total;
    final points = <Offset>[];
    for (var d = 0.0; d < total; d += dash + gap) {
      points
        ..add(a + dir * d)
        ..add(a + dir * (d + dash).clamp(0, total));
    }
    canvas.drawPoints(ui.PointMode.lines, points, paint);
  }

  @override
  bool shouldRepaint(_MizigePainter old) => old.color != color;
}
