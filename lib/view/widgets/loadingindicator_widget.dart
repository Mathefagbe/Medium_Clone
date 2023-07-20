import 'package:flutter/material.dart';

import '../style/colors/colorstyle.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: ColorStyle.lightgreen,
    ));
  }
}
