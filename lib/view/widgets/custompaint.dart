import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    canvas.drawOval(
        Rect.fromCenter(center: c, width: 40.w, height: 30.h), paint);
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
    canvas.drawOval(
        Rect.fromCenter(center: c, width: 20.w, height: 30.h), paint);
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
    canvas.drawOval(
        Rect.fromCenter(center: c, width: 10.w, height: 30.h), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
