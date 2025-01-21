import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/params/car_params.dart';
import '/core/utils/values/svg_manager.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/diff_img.dart';
import '/core/widgets/error_text.dart';
import '/core/widgets/gaps.dart';
import '/features/cars/domain/entities/car_entity.dart';
import '/features/cars/presentation/cubit/get_cars_cubit/get_cars_cubit.dart';
import '/injection_container.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    BlocProvider.of<GetCarsCubit>(context)
        .getCars(params: const CarParams(onlyCarOffer: 'true'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = appLocalizations.isArLocale;
    return BlocBuilder<GetCarsCubit, GetCarsState>(
      builder: (context, state) {
        if (state is GetCarsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetCarsError) {
          return Center(child: Text(state.message));
        } else if (state is GetCarsSuccess) {
          final List<CarEntity> cars = state.response.data as List<CarEntity>;

          return Column(
            children: [
              Expanded(
                child: cars.isEmpty
                    ? Center(
                        child: ErrorText(
                          width: ScreenUtil().screenWidth,
                          text: 'noData'.tr,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(16.r),
                        child: ListView.separated(
                          itemCount: cars.length,
                          itemBuilder: (context, index) {
                            final car = cars[index];
                            final List<AttributeEntity> attributes =
                                car.attributes as List<AttributeEntity>;
                            if (attributes.isEmpty) {
                              return Container();
                            }
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.carDetailsScreenRoute,
                                    arguments: car);
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border:
                                        Border.all(color: colors.buttonColor)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                isArabic
                                                    ? car.brandNameAr ?? ''
                                                    : car.brandNameEn ?? '',
                                                style: TextStyles.regular12(
                                                    color: colors.main)),
                                            Gaps.vGap10,
                                            Text(
                                                isArabic
                                                    ? car.modelNameAr ?? ''
                                                    : car.modelNameEn ?? '',
                                                style: TextStyles.regular12(
                                                    color:
                                                        colors.lightTextColor)),
                                            Gaps.vGap10,
                                            Text(
                                              isArabic
                                                  ? car.category?.nameAr ?? ''
                                                  : car.category?.nameEn ?? '',
                                              style: TextStyles.regular12(
                                                  color: colors.lightTextColor),
                                            ),
                                          ],
                                        ),
                                        DiffImage(
                                          image: car.images?.first ?? '',
                                          fitType: BoxFit.fitWidth,
                                          height: 100.h,
                                          width: 170.w,
                                        ),
                                      ],
                                    ),
                                    Gaps.vGap20,
                                    Container(
                                      padding: EdgeInsets.all(12.r),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          color: colors.lightGrey),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Wrap(
                                              spacing: 12.w,
                                              runSpacing: 4.h,
                                              children:
                                                  attributes.map((attribute) {
                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    DiffImage(
                                                      image:
                                                          attribute.imagePath ??
                                                              '',
                                                      height: 15.h,
                                                      width: 15.w,
                                                      color: colors.main,
                                                    ),
                                                    Gaps.hGap6,
                                                    Text(
                                                      isArabic
                                                          ? attribute.nameAr ??
                                                              ''
                                                          : attribute.nameEn ??
                                                              '',
                                                      style:
                                                          TextStyles.regular10(
                                                              color:
                                                                  colors.main),
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'reyal'.tr,
                                                    style: TextStyles.regular16(
                                                        color: colors.main),
                                                  ),
                                                  Gaps.hGap4,
                                                  Text(
                                                    car.finalPrice.toString(),
                                                    style: TextStyles.bold20(
                                                        color: colors.main),
                                                  ),
                                                  Gaps.hGap4,
                                                  Text('/اليوم',
                                                      style:
                                                          TextStyles.regular10(
                                                              color:
                                                                  colors.main)),
                                                ],
                                              ),
                                              Text(
                                                '${'reyal'.tr} ${car.price.toString()}${'per_day'.tr}',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: colors.errorColor,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gaps.vGap10,
                                    Row(
                                      children: [
                                        SvgPicture.asset(SvgAssets.location),
                                        Gaps.hGap4,
                                        Text(
                                          car.cities!.isNotEmpty
                                              ? isArabic
                                                  ? car.cities!.first.nameAr ??
                                                      ''
                                                  : car.cities!.first.nameEn ??
                                                      ''
                                              : 'selected_location_area'.tr,
                                          style: TextStyles.regular10(
                                              color: colors.lightTextColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Gaps.vGap16,
                        ),
                      ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
