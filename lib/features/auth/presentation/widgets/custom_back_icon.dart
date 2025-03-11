import 'package:cood/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBack extends StatelessWidget {
  const CustomBack({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: colors.backGround,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: BackButtonIcon(),
      ),
    );
  }
}
