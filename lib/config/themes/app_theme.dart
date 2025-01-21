import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/values/app_colors.dart';
import '../../core/utils/values/fonts.dart';

ThemeData getAppTheme(BuildContext context, bool isLightTheme) {
  return ThemeData(
    extensions: <ThemeExtension<AppColors>>[
      AppColors(
        baseColor: isLightTheme ? MyColors.white : MyColors.black,
        backGround:
            isLightTheme ? MyColors.backGround : MyColors.backGroundDark,
        upBackGround:
            isLightTheme ? MyColors.upBackGround : MyColors.upBackGroundDark,
        main: isLightTheme ? MyColors.main : MyColors.mainDark,
        secondryColor:
            isLightTheme ? MyColors.secondryColor : MyColors.secondryColor,
        textColor: isLightTheme ? MyColors.textColor : MyColors.titleDark,
        highlight: isLightTheme ? MyColors.highlight : MyColors.highlightDark,
        body: isLightTheme ? MyColors.body : MyColors.bodyDark,
        iconColor: isLightTheme ? MyColors.iconColor : MyColors.unselectedDark,
        dividerColor:
            isLightTheme ? MyColors.dividerColor : MyColors.dividerDarkColor,
        unselected:
            isLightTheme ? MyColors.unselected : MyColors.unselectedDark,
        successColor:
            isLightTheme ? MyColors.successColor : MyColors.successDarkColor,
        errorColor:
            isLightTheme ? MyColors.errorColor : MyColors.errorDarkColor,
        borderColor: MyColors.borderColor,
        review: MyColors.review,
        buttonColor: MyColors.buttonColor,
        buttonColor2: MyColors.buttonColor2,
        blackColor: MyColors.blackColor,
        secondary: MyColors.secondary,
        lightTextColor: MyColors.lightTextColor,
        lightGrey: MyColors.lightGrey,
      )
    ],
    fontFamily: Fonts.primary,
    brightness: isLightTheme ? Brightness.light : Brightness.dark,
    primaryColor: isLightTheme ? MyColors.main : MyColors.mainDark,
    unselectedWidgetColor:
        isLightTheme ? MyColors.unselected : MyColors.unselectedDark,
    colorScheme: isLightTheme
        ? const ColorScheme.light(
            brightness: Brightness.light,
            primary: MyColors.main,
            error: MyColors.errorColor,
          )
        : const ColorScheme.dark(
            brightness: Brightness.dark,
            primary: MyColors.mainDark,
            error: MyColors.errorDarkColor,
          ),
    dividerTheme: DividerThemeData(
      thickness: 1,
      indent: 4.w,
      endIndent: 4.w,
      color: isLightTheme ? MyColors.dividerColor : MyColors.dividerDarkColor,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all<Color>(MyColors.upBackGround),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: MyColors.main,
    ),
    scaffoldBackgroundColor:
        isLightTheme ? MyColors.upBackGround : MyColors.backGroundDark,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor:
          isLightTheme ? MyColors.upBackGround : MyColors.upBackGroundDark,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor:
          isLightTheme ? MyColors.upBackGround : MyColors.upBackGroundDark,
      titleSpacing: 35.w,
      toolbarHeight: 70.h,
      actionsIconTheme: IconThemeData(
        color: isLightTheme ? MyColors.textColor : MyColors.titleDark,
        size: 24.r,
      ),
      iconTheme: IconThemeData(
        color: isLightTheme ? MyColors.main : MyColors.main,
        size: 24.r,
      ),
      titleTextStyle: TextStyle(
        fontFamily: Fonts.primary,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: isLightTheme ? MyColors.main : MyColors.main,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor:
          isLightTheme ? MyColors.upBackGround : MyColors.upBackGroundDark,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontFamily: Fonts.primary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: isLightTheme ? MyColors.textColor : MyColors.titleDark,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: Fonts.primary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: isLightTheme ? MyColors.iconColor : MyColors.unselectedDark,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      },
    ),
    useMaterial3: false,
  );
}
