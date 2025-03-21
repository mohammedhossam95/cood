// ignore_for_file: must_be_immutable

import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/core/widgets/diff_img.dart';
import 'package:cood/core/widgets/error_text.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/features/categories/presentation/widgets/my_progress.dart';
import 'package:cood/features/home/domain/entities/user_gallary_entity.dart';
import 'package:cood/features/home/presentation/cubit/get_all_user_gallary/get_user_gallary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/get_all_user_gallary/get_user_gallary_states.dart';

class MySocialPhotos extends StatelessWidget {
  MySocialPhotos({super.key});
  List<String> gridImages = [
    'assets/images/gridImage.png',
    'assets/images/gridImage3.png',
    'assets/images/gridImage2.png',
    'assets/images/gridImage.png',
    'assets/images/gridImage3.png',
    'assets/images/gridImage2.png',
    'assets/images/gridImage.png',
    'assets/images/gridImage3.png',
    'assets/images/gridImage2.png',
    'assets/images/gridImage.png',
    'assets/images/gridImage3.png',
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
              child: BlocBuilder<GetUserGallaryCubit, GetUserGallaryState>(
                builder: (context, state) {
                  if (state is GetUserGallaryLoading) {
                    return const Center(
                      child: MyProgrees(),
                    );
                    //----------------- this condition should be (state is CategoriesSuccerss)
                  } else if (state is GetUserGallarySuccerss) {
                    List<UserGalleryEntity> gallaryList =
                        state.response.data as List<UserGalleryEntity>;
                    return (gallaryList.isNotEmpty)
                        ? GridView.builder(
                            itemCount: gallaryList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                child: DiffImage(
                                  image: gallaryList[index].imageUrl ?? '',
                                  userName: gallaryList[index].imagePath ?? '',
                                ),
                              );
                            },
                          )
                        : const SizedBox();
                  } else if(state is GetUserGallaryFailure) {
                    return ErrorText(
                        text: state.errorMessage,
                        width: ScreenUtil().screenWidth,
                      );
                  }else{
                    return const SizedBox();
                  }
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
                    textColor: MyColors.backGround,
                    onPressed: () {},
                    height: 50.h,
                    btnText: 'addPhoto',
                    svgAsset: 'assets/images/Camera.svg',
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
