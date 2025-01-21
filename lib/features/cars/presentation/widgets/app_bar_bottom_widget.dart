import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/params/car_params.dart';
import '/core/utils/values/svg_manager.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/features/cars/presentation/cubit/get_cars_cubit/get_cars_cubit.dart';
import '/injection_container.dart';

class AppBarBottomWidget extends StatefulWidget {
  const AppBarBottomWidget(
      {super.key,
      required this.longitude,
      required this.latitude,
      required this.params});
  final double longitude, latitude;
  final CarParams params;

  @override
  State<AppBarBottomWidget> createState() => _AppBarBottomWidgetState();
}

class _AppBarBottomWidgetState extends State<AppBarBottomWidget> {
  CarParams get params => widget.params;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: const BeveledRectangleBorder(),
      margin: EdgeInsets.only(bottom: 8.r),
      child: Container(
        padding: EdgeInsets.all(22.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.newMapScreenRoute,
                    arguments: params);
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    SvgAssets.map,
                    colorFilter: ColorFilter.mode(colors.main, BlendMode.srcIn),
                  ),
                  Gaps.hGap10,
                  Text(
                    'map'.tr,
                    style: TextStyles.semiBold14(color: colors.main),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.sortingSreenRoute,
                    arguments: params);
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    SvgAssets.filter,
                    colorFilter: ColorFilter.mode(colors.main, BlendMode.srcIn),
                  ),
                  Gaps.hGap10,
                  Text(
                    'filter'.tr,
                    style: TextStyles.semiBold14(color: colors.main),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  barrierColor: Colors.black.withOpacity(.4),
                  context: context,
                  builder: (context) {
                    return Stack(
                      children: [
                        Positioned(
                          top: AppBar().preferredSize.height + 85.h,
                          left: 0,
                          right: 0,
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.all(16.r),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(16.r),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                      'الأقرب لك',
                                      style: TextStyles.semiBold14(
                                          color: colors.main),
                                    ),
                                    onTap: () {
                                      log("latitude:${widget.latitude} longitude:${widget.longitude}");
                                      Navigator.pop(context);
                                      BlocProvider.of<GetCarsCubit>(context)
                                          .getCars(
                                              params: params.copyWith(
                                        latitude: widget.latitude.toString(),
                                        longitude: widget.longitude.toString(),
                                      ));
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      'الأقل سعر',
                                      style: TextStyles.semiBold14(
                                          color: colors.main),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      BlocProvider.of<GetCarsCubit>(context)
                                          .getCars(
                                              params: params.copyWith(
                                        sortByLowerPrice: 'true',
                                      ));
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      "latest".tr,
                                      style: TextStyles.semiBold14(
                                          color: colors.main),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      BlocProvider.of<GetCarsCubit>(context)
                                          .getCars(
                                              params: params.copyWith(
                                        sortByLatestYear: 'true',
                                      ));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        SvgAssets.arrowDown,
                        colorFilter:
                            ColorFilter.mode(colors.main, BlendMode.srcIn),
                      ),
                      SvgPicture.asset(
                        SvgAssets.arrowUp,
                        colorFilter:
                            ColorFilter.mode(colors.main, BlendMode.srcIn),
                      ),
                    ],
                  ),
                  Gaps.hGap10,
                  Text(
                    'sort'.tr,
                    style: TextStyles.semiBold14(color: colors.main),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
