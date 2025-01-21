import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/features/auth/data/models/welcome_model.dart';
import '/injection_container.dart';

class MyPageView extends StatelessWidget {
  final int index;
  final WelcomeData page;
  final ValueChanged<int>? updateIndex;
  const MyPageView(
      {super.key, required this.index, required this.page, this.updateIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ScreenUtil().screenHeight * .08,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset(
                page.image ?? '',
                height: ScreenUtil().screenHeight * .4,
              ),
            ),
            Gaps.vGap40,
            SizedBox(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'onBoarding_title_1'.tr,
                            style: TextStyles.bold30().copyWith(
                              fontWeight: FontWeight.w800,
                              color: colors.main,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'onBoarding_title_2'.tr,
                            style: TextStyles.bold24().copyWith(
                              fontWeight: FontWeight.w800,
                              color: colors.main,
                            ),
                          ),
                          Gaps.vGap22,
                          Text(
                            'onBoarding_details'.tr,
                            style: TextStyles.medium17(),
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        Gaps.vGap15,
                        _buildDots(context: context, currentIndex: index),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().screenWidth * .3,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  // Positioned(
  //   bottom: ScreenUtil.defaultSize.height * .425,
  //   // right: 10.w,
  //   left: 10.w,
  //   child: FloatingActionButton(
  //     backgroundColor: Colors.transparent,
  //     elevation: 0,
  //     shape: const CircleBorder(),
  //     onPressed: () {
  //       if (_currentIndex < 2) {
  //         _currentIndex++;

  //         _controller.animateToPage(
  //           _currentIndex,
  //           duration: const Duration(milliseconds: 100),
  //           curve: Curves.easeInOut,
  //         );
  //       } else {
  //         Navigator.pushNamed(context, Routes.kindUserRoute);
  //       }
  //     },
  //     child: SvgPicture.asset(
  //       Assets.onBoardingButtonSvg,
  //       width: 60.w,
  //       height: 60.h,
  //     ),
  //   ),
  // ),

  SizedBox _buildDots(
      {required int currentIndex, required BuildContext context}) {
    return SizedBox(
      child: Column(
        children: [
          _buildDot(currentIndex == 0, context),
          Gaps.vGap25,
          _buildDot(currentIndex == 1, context),
          Gaps.vGap25,
          _buildDot(currentIndex == 2, context),
        ],
      ),
    );
  }

  _buildDot(bool isSelected, BuildContext context) {
    return isSelected
        ? Container(
            width: 15.w,
            height: 15.h,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: colors.main,
              shape: BoxShape.circle,
            ),
          )
        : Container(
            width: 15.w,
            height: 15.h,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: const BoxDecoration(
              color: Color(0xffE0E0E0),
              shape: BoxShape.circle,
            ),
          );
  }
}
