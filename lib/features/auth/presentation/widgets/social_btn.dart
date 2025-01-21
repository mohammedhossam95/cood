import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../injection_container.dart';
import '../../../../config/locale/app_localizations.dart';

class SocialButton extends StatelessWidget {
  final String? btnText;
  final Function() onPressed;
  final String? icon;
  final IconData? socialIcon;

  final double? height;
  final double? width;
  const SocialButton({
    super.key,
    this.btnText,
    required this.onPressed,
    this.icon,
    this.socialIcon,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    AppLocalizations locale = AppLocalizations.of(context)!;
    TextTheme theme = Theme.of(context).textTheme;
    return SizedBox(
      width: width ?? screenWidth,
      height: (height ?? 55.0.h),
      child: GestureDetector(
        onTap: () => onPressed(),
        child: Container(
          decoration: BoxDecoration(
            color: colors.upBackGround,
            border: Border.all(color: colors.dividerColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          padding: EdgeInsets.all(12.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                icon!,
                height: 20.0.h,
                width: 20.0.w,
              ),
              SizedBox(
                width: screenWidth * 0.0186,
              ),
              Expanded(
                child: AutoSizeText(
                  locale.text(btnText!),
                  textAlign: TextAlign.center,
                  style: theme.bodyMedium!.copyWith(
                    color: colors.body,
                    fontSize: 16.sp,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
