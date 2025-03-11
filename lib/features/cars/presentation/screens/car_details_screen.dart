import 'dart:developer';

import 'package:cood/features/categories/presentation/cubit/check_reserve_status/check_reserve_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/params/car_params.dart';
import '/core/utils/enums.dart';
import '/core/utils/validator.dart';
import '/core/utils/values/svg_manager.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/app_snack_bar.dart';
import '/core/widgets/cart_widgets.dart';
import '/core/widgets/custom_alert.dart';
import '/core/widgets/diff_img.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/loading_view.dart';
import '/core/widgets/menu_text_form_field.dart';
import '/core/widgets/my_default_button.dart';
import '/features/cars/domain/entities/additional_entity.dart';
import '/features/cars/domain/entities/car_entity.dart';
import '/features/cars/presentation/cubit/get_free_additional_cubit/get_free_additional_cubit.dart';
import '/features/cars/presentation/screens/payment_screen.dart';
import '/features/cars/presentation/widgets/branches_list.dart';
import '/injection_container.dart';
import '../cubit/get_additional_cubit/get_additional_cubit.dart';

class CarDetailsArgs {
  final CarEntity car;
  final CarParams params;
  CarDetailsArgs({required this.car, required this.params});
}

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key, required this.car, required this.params});
  final CarEntity car;
  final CarParams params;

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  CarParams get params => widget.params;
  int time1 = 0;
  int time2 = 0;
  int time3 = 0;
  TextEditingController fromCityController = TextEditingController();
  TextEditingController toCityController = TextEditingController();
  FocusNode fromCityFocusNode = FocusNode();
  FocusNode toCityFocusNode = FocusNode();
  int? fromBranchId;
  int? toBranchId;
  bool isSamePickupLocation = true;
  List<int> additionalIds = [];
  bool isAdditionalSelected = false;

  @override
  initState() {
    BlocProvider.of<GetAdditionalCubit>(context).getAdditional(CarParams(
        customerId: widget.car.customer?.id.toString(),
        cats: widget.car.category?.id.toString()));
    BlocProvider.of<GetFreeAdditionalCubit>(context).getFreeAdditional(
        CarParams(
            customerId: widget.car.customer?.id.toString(),
            cats: widget.car.category?.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<AttributeEntity> attributes =
        widget.car.attributes as List<AttributeEntity>;
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
              'car_details'.tr,
              style: TextStyles.semiBold14(color: colors.upBackGround),
            ),
          ),
        ],
        // title:
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.hGap24,
                    Text(
                        isArabic
                            ? widget.car.brandNameAr ?? ''
                            : widget.car.brandNameEn ?? '',
                        style: TextStyles.regular12(color: colors.main)),
                    Gaps.hGap24,
                    DiffImage(
                      image: widget.car.images?.first ?? '',
                      fitType: BoxFit.cover,
                      height: 120.h,
                      width: 250.w,
                    ),
                    const Spacer()
                  ],
                ),
              ),
              Gaps.vGap16,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: colors.main,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        isArabic
                            ? widget.car.modelNameAr ?? ''
                            : widget.car.modelNameEn ?? '',
                        style:
                            TextStyles.regular12(color: colors.upBackGround)),
                    Text(
                        isArabic
                            ? widget.car.category?.nameAr ?? ''
                            : widget.car.category?.nameEn ?? '',
                        style:
                            TextStyles.regular12(color: colors.upBackGround)),
                  ],
                ),
              ),
              Gaps.vGap16,
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 30.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: colors.lightGrey,
                ),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 6.h,
                  spacing: 12.w,
                  children: attributes.map((attribute) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DiffImage(
                          image: attribute.imagePath ?? '',
                          height: 17.h,
                          width: 17.w,
                        ),
                        Gaps.hGap6,
                        Text(
                          isArabic
                              ? attribute.nameAr ?? ''
                              : attribute.nameEn ?? '',
                          style: TextStyles.regular10(color: colors.main),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              Gaps.vGap20,
              Row(
                children: [
                  SvgPicture.asset(SvgAssets.location, height: 24.h),
                  Gaps.hGap10,
                  Text(
                    'selected_pickup_city'.tr,
                    style: TextStyles.regular12(color: colors.buttonColor),
                  )
                ],
              ),
              Gaps.vGap8,
              Padding(
                padding: EdgeInsetsDirectional.only(start: 10.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      SvgAssets.line,
                      height: 60.h,
                    ),
                    Gaps.hGap12,
                    Expanded(
                      child: InkWell(
                        onTap: () => showCitiesSheet(isFromCity: true),
                        child: MenuTextFormField(
                          onTap: () => showCitiesSheet(isFromCity: true),
                          controller: fromCityController,
                          focusNode: fromCityFocusNode,
                          hintText: 'choose_city'.tr,
                          validate: (value) => Validator.call(
                              value: value, type: ValidatorType.standard),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.vGap8,
              _buildCheckboxOption(
                'return_to_same_location',
                isSamePickupLocation,
                (value) {
                  setState(() {
                    isSamePickupLocation = value ?? false;
                  });
                },
              ),
              if (isSamePickupLocation == false) ...[
                Row(
                  children: [
                    SvgPicture.asset(SvgAssets.location, height: 24.h),
                    Gaps.hGap10,
                    Text(
                      'selected_delivery_location'.tr,
                      style: TextStyles.regular12(color: colors.buttonColor),
                    )
                  ],
                ),
                Gaps.vGap8,
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 10.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        SvgAssets.line,
                        height: 60.h,
                      ),
                      Gaps.hGap12,
                      Expanded(
                        child: InkWell(
                          onTap: () => showCitiesSheet(isFromCity: false),
                          child: MenuTextFormField(
                            onTap: () => showCitiesSheet(isFromCity: false),
                            controller: toCityController,
                            focusNode: toCityFocusNode,
                            hintText: 'choose_city'.tr,
                            validate: (value) => Validator.call(
                                value: value, type: ValidatorType.standard),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Gaps.vGap4,
              Text(
                'included_in_price'.tr,
                style: TextStyles.regular12(color: colors.buttonColor),
              ),
              Gaps.vGap4,
              BlocBuilder<GetAdditionalCubit, GetAdditionalState>(
                builder: (context, state) {
                  if (state is GetAdditionalLoading) {
                    return ListView.separated(
                        separatorBuilder: (context, index) => Gaps.vGap2,
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) => Skeletonizer(
                              child: Container(
                                height: 20.h,
                                width: 200.w,
                                color: Colors.grey[200],
                              ),
                            ));
                  } else if (state is GetAdditionalSuccess) {
                    List<AdditionalEntity> additional =
                        state.response.data as List<AdditionalEntity>;
                    return ListView.separated(
                        separatorBuilder: (context, index) => Gaps.vGap2,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return buildPricRow(
                              title: isArabic
                                  ? additional[index].nameAr ?? ''
                                  : additional[index].nameEn ?? '');
                        },
                        itemCount: additional.length);
                  } else if (state is GetAdditionalError) {
                    if (state.message.isNotEmpty) {
                      return Center(child: Text(state.message));
                    }
                  }
                  return Container();
                },
              ),
              Gaps.vGap8,
              Divider(
                color: colors.buttonColor,
                thickness: 1,
              ),
              Text(
                'supplementary_services'.tr,
                style: TextStyles.regular12(color: colors.buttonColor),
              ),
              Gaps.vGap8,
              BlocBuilder<GetAdditionalCubit, GetAdditionalState>(
                builder: (context, state) {
                  if (state is GetAdditionalLoading) {
                    return ListView.separated(
                        separatorBuilder: (context, index) => Gaps.vGap2,
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) => Skeletonizer(
                              child: Container(
                                height: 20.h,
                                width: 200.w,
                                color: Colors.grey[200],
                              ),
                            ));
                  } else if (state is GetAdditionalSuccess) {
                    List<AdditionalEntity> additional =
                        state.response.data as List<AdditionalEntity>;
                    return ListView.separated(
                        separatorBuilder: (context, index) => Gaps.vGap2,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return buildServiceContainer(
                            title: isArabic
                                ? additional[index].nameAr ?? ''
                                : additional[index].nameEn ?? '',
                            price: additional[index].price.toString(),
                            value: isAdditionalSelected,
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  additionalIds.add(additional[index].id!);
                                } else {
                                  additionalIds.remove(additional[index].id!);
                                }
                                isAdditionalSelected = !isAdditionalSelected;
                                log(additionalIds.toString());
                              });
                            },
                          );
                        },
                        itemCount: additional.length);
                  } else if (state is GetAdditionalError) {
                    if (state.message.isNotEmpty) {
                      return Center(child: Text(state.message));
                    }
                  }
                  return Container();
                },
              ),
              Gaps.vGap8,
              Divider(
                color: colors.buttonColor,
                thickness: 1,
              ),
              Text(
                'choose_a_child_infant_seat'.tr,
                style: TextStyles.regular12(color: colors.buttonColor),
              ),
              Gaps.vGap8,
              Row(
                children: [
                  childWidget(
                    time: time1,
                    onTimeChanged: (newTime) {
                      setState(() {
                        time1 = newTime;
                      });
                    },
                    title: 'infant_seat'.tr,
                    duration: '0-12 شهر',
                    image: SvgAssets.childrenChair,
                  ),
                  Gaps.hGap8,
                  childWidget(
                    time: time2,
                    onTimeChanged: (newTime) {
                      setState(() {
                        time2 = newTime;
                      });
                    },
                    title: 'child_seat'.tr,
                    duration: '1-3 سنوات',
                    image: SvgAssets.childrenChair2,
                  ),
                  Gaps.hGap8,
                  childWidget(
                    time: time3,
                    onTimeChanged: (newTime) {
                      setState(() {
                        time3 = newTime;
                      });
                    },
                    title: 'child_seat'.tr,
                    duration: '4-7 سنوات',
                    image: SvgAssets.childrenChair1,
                  ),
                ],
              ),
              Gaps.vGap20,
              BlocConsumer<CheckReserveStatusCubit, CheckReserveStatusState>(
                listener: (context, reserveState) {
                  if (reserveState is CheckReserveStatusSuccess) {
                    Navigator.pushNamed(
                      context,
                      Routes.paymentScreenRoute,
                      arguments: PaymentScreenArgs(
                        car: widget.car,
                        attributes: widget.car.attributes ?? [],
                        params: params.copyWith(
                          fromBranchId: fromBranchId.toString(),
                          toBranchId: isSamePickupLocation
                              ? fromBranchId.toString()
                              : toBranchId.toString(),
                          additionalIds: additionalIds,
                          carId: widget.car.id.toString(),
                          customerId: widget.car.customer?.id.toString(),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, reserveState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (reserveState is CheckReserveStatusError) ...[
                        const SizedBox(height: 8.0),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            reserveState.message,
                            textAlign: TextAlign.center,
                            style: TextStyles.regular12(color: Colors.red),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                      (reserveState is CheckReserveStatusLoading)
                          ? Center(
                              child: LoadingView(
                              bgColor: colors.secondary,
                              width: double.infinity,
                            ))
                          : MyDefaultButton(
                              onPressed: () {
                                if (sharedPreferences.getUserType() ==
                                    UserType.approved) {
                                  if ((toBranchId == null &&
                                          isSamePickupLocation == false) ||
                                      fromBranchId == null) {
                                    return showAppSnackBar(
                                        context: context,
                                        message:
                                            'please_choose_delivery_and_pickup_location'
                                                .tr,
                                        type: ToastType.info);
                                  }
                                  BlocProvider.of<CheckReserveStatusCubit>(
                                          context)
                                      .fCheckStatus(params.copyWith(
                                    fromBranchId: fromBranchId.toString(),
                                    toBranchId: isSamePickupLocation
                                        ? fromBranchId.toString()
                                        : toBranchId.toString(),
                                    additionalIds: additionalIds,
                                    carId: widget.car.id.toString(),
                                    customerId:
                                        widget.car.customer?.id.toString(),
                                  ));
                                } else {
                                  CustomAlert().showAlertDialog(
                                    context: context,
                                    onpress: () {
                                      Navigator.pushNamed(
                                          context, Routes.loginScreenRoute);
                                    },
                                    title: "welcome_to_app_title".tr,
                                    subTitle: "welcome_to_app_message".tr,
                                    btnTitle: "login",
                                  );
                                }
                              },
                              btnText: 'continue',
                              color: colors.secondary,
                            ),
                    ],
                  );
                },
              ),
              Gaps.vGap20,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxOption(
      String text, bool isSelected, Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: isSelected,
          onChanged: onChanged,
          checkColor: Colors.white,
          activeColor: colors.main,
        ),
        Text(
          text.tr,
          style: TextStyles.regular14(),
        ),
      ],
    );
  }

  void showCitiesSheet({required bool isFromCity}) {
    showModalBottomSheet(
      constraints: BoxConstraints(
        maxHeight: ScreenUtil().screenHeight * 0.75,
      ),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      context: context,
      builder: (context) => BranchesList(
        updateSelected: (value) {
          if (value != null) {
            setState(() {
              if (isFromCity) {
                fromBranchId = value.id;
                fromCityController.text = value.nameAr ?? '';
              } else {
                toBranchId = value.id;
                toCityController.text = value.nameAr ?? '';
              }
            });
          } else {
            setState(() {
              if (isFromCity) {
                fromBranchId = null;
                fromCityController.clear();
              } else {
                toBranchId = null;
                toCityController.clear();
              }
            });
          }
        },
      ),
    );
  }

  childWidget({
    required int time,
    required Function(int) onTimeChanged,
    required String title,
    required String duration,
    required String image,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colors.buttonColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              height: 49.h,
              width: 49.w,
            ),
            Gaps.vGap2,
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.regular12(color: colors.textColor),
            ),
            Text(
              duration,
              style: TextStyles.regular12(color: colors.buttonColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MinusWidget(
                  onTap: () {
                    if (time > 0) {
                      onTimeChanged(time - 1);
                    }
                  },
                ),
                Text(
                  '$time',
                  style: TextStyles.regular14(),
                ),
                PlusWidget(
                  onTap: () {
                    onTimeChanged(time + 1);
                  },
                ),
              ],
            ),
            Text(
              '${time * 100} ريال',
              style: TextStyles.regular12(color: colors.buttonColor),
            ),
          ],
        ),
      ),
    );
  }
}

buildServiceContainer(
    {required String title,
    required String price,
    bool value = false,
    required Function(bool?) onChanged}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: colors.buttonColor),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.regular12(),
            ),
            Text(
              "$price ${'reyal'.tr}",
              style: TextStyles.regular12(color: colors.buttonColor),
            )
          ],
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: colors.main,
          checkColor: Colors.white,
        )
      ],
    ),
  );
}

buildPricRow({required String title}) {
  return Row(
    children: [
      SvgPicture.asset(SvgAssets.done, height: 14.h),
      Gaps.hGap10,
      Text(
        title,
        style: TextStyles.regular12(),
      )
    ],
  );
}
