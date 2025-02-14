import 'package:flutter/material.dart';

class LinePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, 0); // Start at the top-left
    path.lineTo(size.width, 0); // Top line
    path.lineTo(size.width, size.height); // Right line
    path.lineTo(0, size.height); // Bottom line (without closing)

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
