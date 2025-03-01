import 'package:cood/config/locale/app_localizations.dart';
import 'package:cood/core/utils/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  () => Navigator.of(context).pop(),
      child: Container(
        height: 38.h,
        width: 38.w,
        decoration: BoxDecoration(
          color: MyColors.arrowBackGrey,
          borderRadius: BorderRadius.circular(6.0.r),
        ),
        child: Icon(
          AppLocalizations.of(context)!.isArLocale
              ? Icons.arrow_forward_ios_outlined
              : Icons.arrow_back_ios_new_rounded,
          size: 24.w,
          color: MyColors.black,
        ),
      ),
    );
  }
}

// Container(
//                       height: 35.h,
//                       width: 35.w,
//                       decoration: BoxDecoration(
//                         color: MyColors.arrowBackGrey,
//                         borderRadius: BorderRadius.circular(6.0.r),
//                       ),
//                       child: Icon(Icons.arrow_back_ios_new_outlined,),
//                     ),
