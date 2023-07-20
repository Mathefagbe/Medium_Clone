import 'package:flutter/material.dart';

import '../style/colors/colorstyle.dart';

class ReuseableBtn extends StatelessWidget {
  const ReuseableBtn(
      {super.key,
      required this.loading,
      required this.text,
      required this.ontap});
  final String text;
  final void Function() ontap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorStyle.lightgreen[400],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: ColorStyle.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
