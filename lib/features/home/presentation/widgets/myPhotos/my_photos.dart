// ignore_for_file: must_be_immutable

import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySocialPhotos extends StatelessWidget {
  MySocialPhotos({super.key});
  List<String> gridImages = [
    'assets/images/gridImage.png',
    'assets/images/gridImage.png',
    'assets/images/gridImage.png',
    'assets/images/gridImage.png',
    'assets/images/gridImage.png',
    'assets/images/gridImage.png',
    'assets/images/gridImage.png',
    'assets/images/gridImage.png',
    'assets/images/gridImage.png',
    'assets/images/gridImage.png',
    'assets/images/gridImage.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: MyColors.upBackGround,
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: [
                  BoxShadow(
                    color: MyColors.body.withValues(alpha: .5), // Shadow color
                    spreadRadius: 2.r, // Spread radius
                    blurRadius: 10.r, // Blur radius
                    offset: Offset(0, 3), // Offset in x and y directions
                  ),
                ],
              ),
              child: GridView.builder(
              itemCount: gridImages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15.0.w,
                mainAxisSpacing: 15.0.h,
                
              ),
              itemBuilder: (context, index) {
                return Container(
                  width: 100.0.w,
                  height: 100.0.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Image.asset(
                    gridImages[index],
                    fit: BoxFit.cover, // Ensures the image fits well
                  ),
                );
              },
            ),
            ),
          ),
          Gaps.vGap20,
          //-----------------4
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10.h),
                  child: MyDefaultButton(
                    onPressed: () {},
                    height: 50.h,
                    btnText: 'save',
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(10.h),
                  child: MyDefaultButton(
                    svgAsset: 'assets/images/Camera.svg',
                    onPressed: () {},
                    height: 50.h,
                    btnText: 'pic_A_Photo',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
