import 'package:flutter/material.dart';

class ParchmentBackground extends StatelessWidget {
  final Widget child;

  const ParchmentBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: _DotPatternPainter())),
        child,
      ],
    );
  }
}

class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Paint()..color = const Color(0x0D785A28); // rgba(120,90,40,.05)
    final p2 = Paint()..color = const Color(0x0A785A28); // rgba(120,90,40,.04)

    for (double x = 0; x < size.width; x += 7) {
      for (double y = 0; y < size.height; y += 7) {
        canvas.drawCircle(Offset(x, y), 1.0, p1);
      }
    }

    for (double x = 3; x < size.width + 11; x += 11) {
      for (double y = 4; y < size.height + 11; y += 11) {
        canvas.drawCircle(Offset(x, y), 1.0, p2);
      }
    }
  }

  @override
  bool shouldRepaint(_DotPatternPainter oldDelegate) => false;
}
