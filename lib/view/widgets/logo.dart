import 'package:dblog/view/widgets/custompaint.dart';
import 'package:flutter/material.dart';

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
        const SizedBox(
          width: 30,
        ),
        CustomPaint(
          painter: PaintSmall(color: color),
        ),
        const SizedBox(
          width: 15,
        ),
        CustomPaint(
          painter: PaintSmallest(color: color),
        ),
      ],
    );
  }
}
