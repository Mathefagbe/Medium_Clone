import 'package:flutter/material.dart';

import '../style/colors/colorstyle.dart';

InputDecoration formDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
      gapPadding: 2,
      borderSide: BorderSide(color: ColorStyle.lightgreen.withOpacity(0.3)),
      borderRadius: BorderRadius.circular(3)),
  enabled: true,
  enabledBorder: UnderlineInputBorder(
      borderSide:
          BorderSide(width: 1, color: ColorStyle.lightgray.withOpacity(0.2))),
);
