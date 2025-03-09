import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '/injection_container.dart';

class MyProgrees extends StatelessWidget {
  final Color? color;
  final double? size;
  const MyProgrees({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.threeArchedCircle(
      color: color ?? colors.main,
      size: size ?? 70.r,
    );
    // return LoadingAnimationWidget.staggeredDotsWave(
    //   color: color ?? colors(context).main,
    //   size: size ?? 80.r,
    // );
    // return LoadingAnimationWidget.fourRotatingDots(
    //   color: color ?? colors(context).main,
    //   size: size ?? 80.r,
    // );
    ///
    // return SvgPicture.asset(
    //   SvgAssets.carLoader,
    //   width: size ?? 80.w,
    //   height: size ?? 80.h,
    //   fit: BoxFit.scaleDown,
    // );
    // return Image.asset(
    //   GifAssets.carLoader,
    //   width: size ?? 80.w,
    //   height: size ?? 80.h,
    //   fit: BoxFit.scaleDown,
    // );
    // return Lottie.asset(
    //   AnimationAssets.loading,
    //   // width: size ?? 80.w,
    //   // height: size ?? 80.h,
    // );
  }
}
