import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '/core/utils/values/svg_manager.dart';

class PlusWidget extends StatelessWidget {
  final void Function() onTap;
  const PlusWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        SvgAssets.plus,
        height: 25.h,
        width: 25.w,
      ),
    );
  }
}

class MinusWidget extends StatelessWidget {
  final void Function() onTap;
  const MinusWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        SvgAssets.minus,
        height: 25.h,
        width: 25.w,
      ),
    );
  }
}
