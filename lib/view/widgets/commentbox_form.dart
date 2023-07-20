import 'package:flutter/material.dart';

InputDecoration formBox = InputDecoration(
  focusedBorder: OutlineInputBorder(
      gapPadding: 2,
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(3)),
  enabled: true,
  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
);
