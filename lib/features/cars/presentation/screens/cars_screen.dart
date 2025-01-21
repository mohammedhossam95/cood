// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

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
import '/features/cars/presentation/screens/car_details_screen.dart';
import '/features/cars/presentation/widgets/app_bar_bottom_widget.dart';
import '/injection_container.dart';

class CarsScreen extends StatefulWidget {
  final CarParams params;
  const CarsScreen({super.key, required this.params});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied. We cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  double? latitude, longitude;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetCarsCubit>(context).getCars(params: widget.params);
    _getCurrentLocation().then((position) {
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = appLocalizations.isArLocale;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: colors.upBackGround,
        ),
        backgroundColor: colors.main,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: Text(
              isArabic
                  ? widget.params.city?.nameAr ?? ''
                  : widget.params.city?.nameEn ?? '',
              style: TextStyles.semiBold14(color: colors.upBackGround),
            ),
          ),
        ],
        // title:
      ),
      body: BlocBuilder<GetCarsCubit, GetCarsState>(
        builder: (context, state) {
          if (state is GetCarsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetCarsError) {
            return Center(child: Text(state.message));
          } else if (state is GetCarsSuccess) {
            final List<CarEntity> cars = state.response.data as List<CarEntity>;

            return Column(
              children: [
                AppBarBottomWidget(
                  latitude: latitude ?? 0.0,
                  longitude: longitude ?? 0.0,
                  params: widget.params,
                ),
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
                                      arguments: CarDetailsArgs(
                                          car: car, params: widget.params));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16.r),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                          color: colors.buttonColor)),
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
                                                      color: colors
                                                          .lightTextColor)),
                                              Gaps.vGap10,
                                              Text(
                                                isArabic
                                                    ? car.category?.nameAr ?? ''
                                                    : car.category?.nameEn ??
                                                        '',
                                                style: TextStyles.regular12(
                                                    color:
                                                        colors.lightTextColor),
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
                                                        image: attribute
                                                                .imagePath ??
                                                            '',
                                                        height: 15.h,
                                                        width: 15.w,
                                                        color: colors.main,
                                                      ),
                                                      Gaps.hGap6,
                                                      Text(
                                                        isArabic
                                                            ? attribute
                                                                    .nameAr ??
                                                                ''
                                                            : attribute
                                                                    .nameEn ??
                                                                '',
                                                        style: TextStyles
                                                            .regular10(
                                                                color: colors
                                                                    .main),
                                                      ),
                                                    ],
                                                  );
                                                }).toList(),
                                              ),
                                            ),
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
                                                  car.price.toString(),
                                                  style: TextStyles.bold20(
                                                      color: colors.main),
                                                ),
                                                Gaps.hGap4,
                                                Text('/اليوم',
                                                    style: TextStyles.regular10(
                                                        color: colors.main)),
                                              ],
                                            )
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
                                                    ? car.cities!.first
                                                            .nameAr ??
                                                        ''
                                                    : car.cities!.first
                                                            .nameEn ??
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
      ),
    );
  }
}
