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
  final String backgroundImage;
  final String bacgroundImage;
  const SocailCircleIcon({
    super.key,
    this.haveBacgroundImage = false,
    this.havechildImage = true,
    this.radius = 21.5,
    this.backgroundColor = MyColors.main,
    this.iconHeight = 30.0,
    this.bacgroundImage = 'assets/images/imo.png',
    this.backgroundImage = 'assets/images/imo.png',
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius.r,
      backgroundColor: backgroundColor,
      backgroundImage: (haveBacgroundImage) ? AssetImage(bacgroundImage) : null,
      child: (havechildImage)
          ? Image.asset(
              backgroundImage,
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
  final double radius;
  final BoxShape shape;
  final Gradient? gradient;
  final String? backgroundImage;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final String? childImagePath; // Updated name for clarity

  const CustomIconWidget({
    super.key,
     this.width=43.0,
     this.height=43.0,
     this.shape=BoxShape.circle,
    this.radius=15.0,
    this.gradient,
    this.backgroundImage,
    this.onPressed,
    this.backgroundColor,
    this.childImagePath, // Use this to pass the image path
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          borderRadius: (shape == BoxShape.rectangle)
              ? BorderRadius.circular(radius.r)
              : null,
          color: backgroundColor,
          shape: shape,
          gradient: gradient,
          image: backgroundImage != null
              ? DecorationImage(
                  image: AssetImage(backgroundImage!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: childImagePath != null
            ? Center(
                // Centers and sizes the image
                child: SizedBox(
                  width: width * 0.7.w, // Adjust as needed
                  height: height * 0.7.h,
                  child: Image.asset(
                    childImagePath!,
                    fit: BoxFit.contain, // Ensures the image scales properly
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
