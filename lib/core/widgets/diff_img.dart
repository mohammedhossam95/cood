import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '/core/utils/extension.dart';
import '../../injection_container.dart';
import '../utils/values/svg_manager.dart';

class DiffImage extends StatelessWidget {
  final dynamic image;
  final dynamic height;
  final dynamic width;
  final dynamic onClick;
  final dynamic fitType;
  final dynamic radius;
  final bool isExpand;
  final bool hasBorder;
  final bool hasShadow;
  final Function? onUserTap;
  final BorderRadius? borderRadius;
  final bool isCircle;
  final Color? color;

  const DiffImage({
    super.key,
    this.image,
    this.height,
    this.width,
    this.radius = 5.0,
    this.isExpand = true,
    this.onClick = true,
    this.hasBorder = false,
    this.onUserTap,
    this.fitType = BoxFit.fill,
    this.hasShadow = false,
    this.borderRadius,
    this.isCircle = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: hasBorder ? EdgeInsets.all(8.w) : null,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
        border: hasBorder ? Border.all(color: colors.borderColor) : null,
        boxShadow: hasShadow == true
            ? const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  blurRadius: 8.0,
                  spreadRadius: 0.0,
                  offset: Offset(0, 2.0),
                ),
              ]
            : [],
      ),
      child: Uri.tryParse(image)?.hasAbsolutePath == true
          ? ClipRRect(
              borderRadius: borderRadius ?? BorderRadius.circular(radius),
              child: CachedNetworkImage(
                memCacheHeight: 320.cacheSize(context),
                memCacheWidth: 250.cacheSize(context),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                imageUrl: image,
                fit: fitType,
                color: color,
                errorWidget: (context, url, error) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(color: colors.borderColor),
                    ),
                    padding: EdgeInsets.all(16.r),
                    // child: SvgPicture.asset(
                    //   SvgAssets.notFound,
                    //   fit: BoxFit.scaleDown,
                    // colorFilter: Constants.colorFilter(Colors.black),
                    // ),
                    child: const Icon(Icons.image_not_supported_rounded),
                  ),
                ),
              ),
            )
          : ClipRRect(
              borderRadius: borderRadius ?? BorderRadius.circular(radius),
              child: Container(
                decoration: isCircle
                    ? const BoxDecoration(
                        shape: BoxShape.circle,
                      )
                    : null,
                padding: EdgeInsets.all(
                    width != double.infinity ? (width * 0.2) : 10.r),
                width: width * 0.6,
                height: height * 0.6,
                child: SvgPicture.asset(
                  SvgAssets.notFound,
                ),
              ),
            ),
    );
  }
}
