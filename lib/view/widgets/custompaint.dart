import 'package:flutter/material.dart';

class Paints extends CustomPainter {
  final Color color;
  const Paints({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..style = PaintingStyle.fill;
    var c = Offset(size.width / 2, size.height / 2);
    canvas.drawOval(Rect.fromCenter(center: c, width: 40, height: 30), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PaintSmall extends CustomPainter {
  final Color color;
  const PaintSmall({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..style = PaintingStyle.fill;
    var c = Offset(size.width / 2, size.height / 2);
    canvas.drawOval(Rect.fromCenter(center: c, width: 20, height: 30), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PaintSmallest extends CustomPainter {
  final Color color;
  const PaintSmallest({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..style = PaintingStyle.fill;
    var c = Offset(size.width / 2, size.height / 2);
    // canvas.drawCircle(c, 10, paint);
    canvas.drawOval(Rect.fromCenter(center: c, width: 10, height: 30), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
