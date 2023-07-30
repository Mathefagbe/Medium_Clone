import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: ColorStyle.lightgreen[400],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            color: ColorStyle.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
