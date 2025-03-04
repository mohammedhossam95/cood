import 'package:cood/core/utils/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class SocailCircleIcon extends StatelessWidget {
  final bool haveBacgroundImage;
  final bool havechildImage;
  final double radius;
  final Color backgroundColor;
  final double iconHeight;
  final String imagePath;
  final String bacgroundImage;
  const SocailCircleIcon({
    super.key,
    this.haveBacgroundImage = false,
    this.havechildImage = true,
    this.radius = 21.5,
    this.backgroundColor = MyColors.main,
    this.iconHeight = 30.0,
    this.bacgroundImage = 'assets/images/imo.png',
    this.imagePath = 'assets/images/imo.png',
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius.r,
      backgroundColor: backgroundColor,
      backgroundImage: (haveBacgroundImage) ? AssetImage(bacgroundImage) : null,
      child: (havechildImage)
          ? Image.asset(
              imagePath,
              height: iconHeight.h,
            )
          : null,
    );
  }
}
//------------------------- custom Icon widget

class CustomIconWidget extends StatelessWidget {
  final double width;
  final double height;
  final BoxShape shape;
  final Gradient? gradient;
  final String? imagePath;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  const CustomIconWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.shape,
    this.gradient,
    this.imagePath,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: shape,
          gradient: gradient,
          image: imagePath != null
              ? DecorationImage(
                  image: AssetImage(imagePath!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
      ),
    );
  }
}
