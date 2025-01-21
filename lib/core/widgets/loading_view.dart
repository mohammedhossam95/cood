import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/extension.dart';
import '../../injection_container.dart';

class LoadingView extends StatelessWidget {
  final Color? bgColor;
  final Color? loadingColor;
  final double? height;
  final double? width;

  const LoadingView({
    super.key,
    this.height,
    this.width,
    this.bgColor,
    this.loadingColor,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: width ?? screenWidth,
      height: (height ?? 60.0).h,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: colors.dividerColor),
        color: bgColor ?? colors.main,
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: loadingColor ?? colors.upBackGround,
        ).appLoading,
      ),
    );
  }
}
