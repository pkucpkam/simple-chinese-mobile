import 'dart:math';

import 'package:flutter/material.dart';

/// Thẻ lật 3D quanh trục Y. Điều khiển bằng [flipped] từ bên ngoài.
class FlipCard extends StatefulWidget {
  const FlipCard({
    super.key,
    required this.front,
    required this.back,
    required this.flipped,
    this.onTap,
    this.duration = const Duration(milliseconds: 450),
  });

  final Widget front;
  final Widget back;
  final bool flipped;
  final VoidCallback? onTap;
  final Duration duration;

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: widget.duration,
    value: widget.flipped ? 1 : 0,
  );
  late final Animation<double> _t =
      CurvedAnimation(parent: _c, curve: Curves.easeInOutCubic);

  @override
  void didUpdateWidget(FlipCard old) {
    super.didUpdateWidget(old);
    if (old.flipped != widget.flipped) {
      widget.flipped ? _c.forward() : _c.reverse();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _t,
        builder: (context, _) {
          final angle = _t.value * pi;
          final showBack = angle > pi / 2;
          return Transform(
            alignment: Alignment.center,
            // setEntry(3, 2, …) thêm phối cảnh để thấy hiệu ứng 3D.
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateY(angle),
            child: showBack
                // Mặt sau được xoay thêm 180° để chữ không bị ngược.
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: widget.back,
                  )
                : widget.front,
          );
        },
      ),
    );
  }
}
