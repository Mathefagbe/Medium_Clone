import 'package:dblog/view/widgets/custompaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).canvasColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPaint(
          painter: Paints(color: color),
        ),
      SizedBox(
          width: 30.w,
        ),
        CustomPaint(
          painter: PaintSmall(color: color),
        ),
      SizedBox(
          width: 15.w,
        ),
        CustomPaint(
          painter: PaintSmallest(color: color),
        ),
      ],
    );
  }
}
