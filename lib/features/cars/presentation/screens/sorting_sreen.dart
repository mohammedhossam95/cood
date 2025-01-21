import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '/config/locale/app_localizations.dart';
import '/core/params/car_params.dart';
import '/core/utils/validator.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/defult_text_field.dart';
import '/core/widgets/diff_img.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/features/cars/domain/entities/car_brand_entity.dart';
import '/features/cars/domain/entities/category_entity.dart';
import '/features/cars/presentation/cubit/get_brands_cubit/get_brands_cubit.dart';
import '/features/cars/presentation/cubit/get_brands_cubit/get_brands_state.dart';
import '/features/cars/presentation/cubit/get_cars_cubit/get_cars_cubit.dart';
import '/features/cars/presentation/cubit/get_categories_cubit/get_categories_cubit.dart';
import '/injection_container.dart';

class SortingScreen extends StatefulWidget {
  final CarParams params;
  const SortingScreen({super.key, required this.params});

  @override
  State<SortingScreen> createState() => _SortingScreenState();
}

class _SortingScreenState extends State<SortingScreen> {
  CarParams get carParams => widget.params;
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final fromFocusNode = FocusNode();
  final toFocusNode = FocusNode();
  List<String> selectedCategoryIds = [];
  List<String> selectedBrandNames = [];

  @override
  Widget build(BuildContext context) {
    final isRtl = AppLocalizations.of(context)!.isArLocale;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Container(
          width: ScreenUtil().screenWidth,
          alignment: isRtl ? Alignment.centerLeft : Alignment.centerRight,
          child: Text('filter'.tr),
        ),
        elevation: 4,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(25.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionTile(
                        shape: Border(
                          bottom: BorderSide(
                            color: colors.buttonColor,
                            width: 1.0,
                          ),
                        ),
                        collapsedShape: Border(
                          bottom: BorderSide(
                            color: colors.buttonColor,
                            width: 1.0,
                          ),
                        ),
                        collapsedIconColor: colors.main,
                        tilePadding: EdgeInsets.zero,
                        title: Text(
                          'price'.tr,
                          style: TextStyles.medium14(color: colors.main),
                        ),
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MyTextFormField(
                                  controller: fromController,
                                  focusNode: fromFocusNode,
                                  hintText: 'from'.tr,
                                  validatorType: ValidatorType.numbersOnly,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Gaps.hGap16,
                              Expanded(
                                child: MyTextFormField(
                                  controller: toController,
                                  focusNode: toFocusNode,
                                  hintText: 'to'.tr,
                                  validatorType: ValidatorType.numbersOnly,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          Gaps.vGap12,
                        ],
                      ),
                      ExpansionTile(
                        shape: Border(
                          bottom: BorderSide(
                            color: colors.buttonColor,
                            width: 1.0,
                          ),
                        ),
                        collapsedShape: Border(
                          bottom: BorderSide(
                            color: colors.buttonColor,
                            width: 1.0,
                          ),
                        ),
                        collapsedIconColor: colors.main,
                        onExpansionChanged: (value) {
                          if (value) {
                            BlocProvider.of<GetCategoriesCubit>(context)
                                .getCategories();
                          }
                        },
                        tilePadding: EdgeInsets.zero,
                        title: Text(
                          'car_type'.tr,
                          style: TextStyles.medium14(color: colors.main),
                        ),
                        children: [
                          BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
                            builder: (context, state) {
                              if (state is GetCategoriesLoading) {
                                return Skeletonizer(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      spacing: 16.w,
                                      runSpacing: 8.h,
                                      children: List.generate(
                                        8,
                                        (index) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Colors.grey.shade200,
                                          ),
                                          width: 51.w,
                                          height: 52.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (state is GetCategoriesSuccess) {
                                final List<CarCategoryEntity> categories = state
                                    .response.data as List<CarCategoryEntity>;
                                return SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    runSpacing: 8.h,
                                    spacing: 16.w,
                                    children: categories.map((category) {
                                      final isSelected = selectedCategoryIds
                                          .contains(category.id.toString());
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (isSelected) {
                                              selectedCategoryIds.remove(
                                                  category.id.toString());
                                            } else {
                                              selectedCategoryIds
                                                  .add(category.id.toString());
                                            }
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8.r),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border: Border.all(
                                              color: isSelected
                                                  ? colors.main
                                                  : colors.upBackGround,
                                              width: 1.0,
                                            ),
                                            color: isSelected
                                                ? colors.main.withOpacity(0.1)
                                                : colors.upBackGround,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              DiffImage(
                                                image: category.imagePath ?? '',
                                                height: 30.h,
                                                width: 50.w,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(0)),
                                                fitType: BoxFit.scaleDown,
                                              ),
                                              Gaps.vGap2,
                                              Text(
                                                isRtl
                                                    ? category.nameAr ?? ''
                                                    : category.nameEn ?? '',
                                                textAlign: TextAlign.center,
                                                style: TextStyles.medium12(
                                                    color: colors.main),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                          Gaps.vGap12,
                        ],
                      ),
                      ExpansionTile(
                        collapsedIconColor: colors.main,
                        shape: Border(
                          bottom: BorderSide(
                            color: colors.buttonColor,
                            width: 1.0,
                          ),
                        ),
                        collapsedShape: Border(
                          bottom: BorderSide(
                            color: colors.buttonColor,
                            width: 1.0,
                          ),
                        ),
                        onExpansionChanged: (value) {
                          if (value) {
                            BlocProvider.of<GetBrandsCubit>(context)
                                .getBrands();
                          }
                        },
                        tilePadding: EdgeInsets.zero,
                        title: Text(
                          'car_brands'.tr,
                          style: TextStyles.medium14(color: colors.main),
                        ),
                        children: [
                          BlocBuilder<GetBrandsCubit, GetBrandsState>(
                            builder: (context, state) {
                              if (state is GetBrandsLoading) {
                                return Skeletonizer(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      spacing: 16.w,
                                      runSpacing: 8.h,
                                      children: List.generate(
                                        8,
                                        (index) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Colors.grey.shade200,
                                          ),
                                          width: 51.w,
                                          height: 52.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (state is GetBrandsSuccess) {
                                final List<CarBrand> brands =
                                    state.response.data as List<CarBrand>;
                                return SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    runSpacing: 8.h,
                                    spacing: 16.w,
                                    children: brands.map((brand) {
                                      final isSelected = selectedBrandNames
                                          .contains(brand.nameEn.toString());
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (isSelected) {
                                              selectedBrandNames.remove(
                                                  brand.nameEn.toString());
                                            } else {
                                              selectedBrandNames
                                                  .add(brand.nameEn.toString());
                                            }
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8.r),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border: Border.all(
                                              color: isSelected
                                                  ? colors.main
                                                  : colors.upBackGround,
                                              width: 1.0,
                                            ),
                                            color: isSelected
                                                ? colors.main.withOpacity(0.1)
                                                : colors.upBackGround,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              DiffImage(
                                                image: brand.imagePath ?? '',
                                                height: 30.h,
                                                width: 50.w,
                                                fitType: BoxFit.cover,
                                              ),
                                              Gaps.vGap2,
                                              Text(
                                                isRtl
                                                    ? brand.nameAr ?? ''
                                                    : brand.nameEn ?? '',
                                                textAlign: TextAlign.center,
                                                style: TextStyles.medium12(
                                                    color: colors.main),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                          Gaps.vGap12,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: MyDefaultButton(
                onPressed: () {
                  final params = carParams.copyWith(
                    fromPrice: fromController.text.isNotEmpty
                        ? fromController.text
                        : null,
                    toPrice:
                        toController.text.isNotEmpty ? toController.text : null,
                    cats: selectedCategoryIds.isNotEmpty
                        ? selectedCategoryIds.join(',')
                        : null,
                    brand: selectedBrandNames.isNotEmpty
                        ? selectedBrandNames.join(',')
                        : null,
                  );

                  log('params: $params');
                  BlocProvider.of<GetCarsCubit>(context)
                      .getCars(params: params);

                  Navigator.pop(context);
                },
                btnText: 'show_results',
                color: colors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
