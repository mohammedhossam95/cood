import 'package:flutter/material.dart';

import '../../../injection_container.dart';

class MyColors {
  static const Color white = Colors.white;
  static const Color backGround = Color(0xFFF0F8FF);
  static const Color upBackGround = Color(0xFFFFFFFF);
  static const Color main = Color(0xff297AFF);
  static const Color secondary = Color(0xffFF781F);
  static const Color secondryColor = Color(0xffF4E5FF);
  static const Color textColor = Color(0xFF656565);
  static const Color body = Color(0xff738277);
  static const Color iconColor = Color(0xFF8A8A8A);
  static const Color title = Color(0xFF3D5F48);
  static const Color highlight = Color(0xFF44584A);
  static const Color buttonColor = Color(0xffC4C4C4);
  static const Color unselected = Color(0xFFB2B8B4);
  static const Color dividerColor = Color(0x26738277);
  static const Color successColor = Color(0xFF0FEF3D);
  static const Color errorColor = Color(0xFFEF0F0F);
  static const Color buttonColor2 = Color(0xFFEEEEEE);
  //--------------------ali
  static const Color facbookItemColor = Color(0xFFECF3FF);
  static const Color whatsAppItemColor = Color(0xFFF2FFF6);
  static const Color tikokItemColor = Color(0xFFEEEEEE);
  static const Color snapShatItemColor = Color(0xFFFFFFD5);
  static const Color socialGreen = Color(0xFF0DBB41);
  static const Color socialYellow = Color(0xFFFFFC01);
  static const Color arrowBackGrey = Color(0xFFD9D9D9);
  static const Color contactCardGrey = Color(0xD9D9D999);
  static const Color lightBlue = Color(0xFFF0F8FF);

//---------insta colors
  static const Color pink = Color(0xFFE1306C); // Instagram Pink
  static const Color orange = Color(0xFFF77737); // Instagram Orange
  static const Color yellow = Color(0xFFFFDC80); // Instagram Yellow
  static const Color purple = Color(0xFFC13584); // Instagram Purple
//---------------
  static const Color blackColor = Colors.black;

  static const Color colorCircle = Color(0xFFF3F7FF);
  static const Color lightTextColor = Color(0xffC4C4C4);
  static const Color lightGrey = Color(0xffF5F5F5);

// dark mode
  static const Color black = Colors.black;
  static const Color backGroundDark = Color(0xFF2D2D3E);
  static const Color upBackGroundDark = Color(0xFF3A3A4B);
  static const Color mainDark = Color(0xFF39DBB4);
  static const Color titleDark = Color(0xFFD3FFF5);
  static const Color highlightDark = Color(0xFFD3E7E2);
  static const Color bodyDark = Color(0xffB2CCC6);
  static const Color unselectedDark = Color(0xFF9DA8A5);
  static const Color dividerDarkColor = Color(0x26738277);
  static const Color successDarkColor = Color(0xFF4CAF50);
  static const Color errorDarkColor = Color(0xFFFF5F5F);

// shared
  static Color borderColor = const Color(0xffCBCBCB);
  static Color review = const Color(0xffFFA534);
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color baseColor;
  final Color backGround;
  final Color upBackGround;
  final Color main;
  final Color secondryColor;
  final Color secondary;
  final Color textColor;
  final Color highlight;
  final Color body;
  final Color iconColor;
  final Color dividerColor;
  final Color unselected;
  final Color successColor;
  final Color errorColor;
  final Color borderColor;
  final Color review;
  final Color buttonColor;
  final Color buttonColor2;
  final Color blackColor;
  final Color lightTextColor;
  final Color lightGrey;

  const AppColors({
    required this.baseColor,
    required this.backGround,
    required this.upBackGround,
    required this.main,
    required this.secondryColor,
    required this.textColor,
    required this.highlight,
    required this.body,
    required this.iconColor,
    required this.dividerColor,
    required this.unselected,
    required this.successColor,
    required this.errorColor,
    required this.borderColor,
    required this.review,
    required this.buttonColor,
    required this.buttonColor2,
    required this.blackColor,
    required this.secondary,
    required this.lightTextColor,
    required this.lightGrey,
  });

  @override
  AppColors copyWith({
    Color? baseColor,
    Color? backGround,
    Color? upBackGround,
    Color? main,
    Color? orangeColor,
    Color? secondryColor,
    Color? textColor,
    Color? highlight,
    Color? body,
    Color? iconColor,
    Color? dividerColor,
    Color? unselected,
    Color? successColor,
    Color? errorColor,
    Color? borderColor,
    Color? review,
    Color? buttonColor,
    Color? buttonColor2,
    Color? blackColor,
    Color? secondary,
    Color? lightTextColor,
    Color? lightGrey,
  }) {
    return AppColors(
      baseColor: baseColor ?? this.baseColor,
      backGround: backGround ?? this.backGround,
      upBackGround: upBackGround ?? this.upBackGround,
      main: main ?? this.main,
      secondryColor: secondryColor ?? this.secondryColor,
      textColor: textColor ?? this.textColor,
      highlight: highlight ?? this.highlight,
      body: body ?? this.body,
      iconColor: iconColor ?? this.iconColor,
      dividerColor: dividerColor ?? this.dividerColor,
      unselected: unselected ?? this.unselected,
      successColor: successColor ?? this.successColor,
      errorColor: errorColor ?? this.errorColor,
      borderColor: borderColor ?? this.borderColor,
      review: review ?? this.review,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonColor2: buttonColor2 ?? this.buttonColor2,
      blackColor: blackColor ?? this.blackColor,
      secondary: secondary ?? this.secondary,
      lightTextColor: lightTextColor ?? this.lightTextColor,
      lightGrey: lightGrey ?? this.lightGrey,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors> other, double t) {
    if (other is! AppColors) {
      return this;
    }
    final appColors = AppColors(
      baseColor: Color.lerp(baseColor, other.baseColor, t) ?? baseColor,
      backGround: Color.lerp(backGround, other.backGround, t) ?? backGround,
      upBackGround:
          Color.lerp(upBackGround, other.upBackGround, t) ?? upBackGround,
      main: Color.lerp(main, other.main, t) ?? main,
      secondryColor:
          Color.lerp(secondryColor, other.secondryColor, t) ?? secondryColor,
      textColor: Color.lerp(textColor, other.textColor, t) ?? textColor,
      highlight: Color.lerp(highlight, other.highlight, t) ?? highlight,
      body: Color.lerp(body, other.body, t) ?? body,
      iconColor: Color.lerp(iconColor, other.iconColor, t) ?? iconColor,
      dividerColor:
          Color.lerp(dividerColor, other.dividerColor, t) ?? dividerColor,
      unselected: Color.lerp(unselected, other.unselected, t) ?? unselected,
      successColor:
          Color.lerp(successColor, other.successColor, t) ?? successColor,
      errorColor: Color.lerp(errorColor, other.errorColor, t) ?? errorColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      review: Color.lerp(review, other.review, t) ?? review,
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t) ?? buttonColor,
      buttonColor2:
          Color.lerp(buttonColor2, other.buttonColor2, t) ?? buttonColor2,
      blackColor: Color.lerp(blackColor, other.blackColor, t) ?? blackColor,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      lightTextColor:
          Color.lerp(lightTextColor, other.lightTextColor, t) ?? lightTextColor,
      lightGrey: Color.lerp(lightGrey, other.lightGrey, t) ?? lightGrey,
    );
    ServiceLocator.injectAppColors(appColors: appColors);
    return appColors;
  }
}
