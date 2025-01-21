import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';

class UserTypeItemWidget extends StatelessWidget {
  final String itemImage;
  final String itemType;
  final double? imageWidth;
  final double? imageHeight;
  final void Function()? onTap;
  const UserTypeItemWidget({
    super.key,
    required this.itemImage,
    required this.itemType,
    this.imageWidth,
    this.imageHeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 16.h,
          ),
          child: Column(
            children: [
              Image.asset(
                itemImage,
                width: imageWidth,
                height: imageHeight,
              ),
              Gaps.vGap8,
              Text(
                itemType,
                style: TextStyles.bold15(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
