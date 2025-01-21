import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/params/car_params.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/custom_alert.dart';
import '/core/widgets/diff_img.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/loading_view.dart';
import '/core/widgets/my_default_button.dart';
import '/features/cars/domain/entities/car_entity.dart';
import '/features/reservations/presentation/cubit/reserve_cubit/reserve_cubit.dart';
import '/features/tabbar/presentation/cubit/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import '/injection_container.dart';

class PaymentScreenArgs {
  final CarEntity car;
  final List<AttributeEntity> attributes;
  final CarParams params;

  PaymentScreenArgs(
      {required this.car, required this.attributes, required this.params});
}

class PaymentScreen extends StatefulWidget {
  final CarEntity car;
  final List<AttributeEntity> attributes;
  final CarParams params;

  const PaymentScreen({
    super.key,
    required this.car,
    required this.attributes,
    required this.params,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  CarParams get params => widget.params;
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
              'payment'.tr,
              style: TextStyles.semiBold14(color: colors.upBackGround),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.hGap24,
                  Text(
                    isArabic
                        ? widget.car.brandNameAr ?? ''
                        : widget.car.brandNameEn ?? '',
                    style: TextStyles.regular12(color: colors.main),
                  ),
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
                      style: TextStyles.regular12(color: colors.upBackGround),
                    ),
                    Text(
                      isArabic
                          ? widget.car.category?.nameAr ?? ''
                          : widget.car.category?.nameEn ?? '',
                      style: TextStyles.regular12(color: colors.upBackGround),
                    ),
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
                child: widget.attributes.isEmpty
                    ? Center(
                        child: Text(
                          'no_attributes'.tr,
                          style: TextStyles.regular12(color: colors.textColor),
                        ),
                      )
                    : Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runSpacing: 6.h,
                        spacing: 12.w,
                        children: widget.attributes.map((attribute) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DiffImage(
                                image: attribute.imagePath ?? '',
                                height: 17.h,
                                width: 17.w,
                                color: colors.main,
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
              Gaps.vGap10,
              FractionallySizedBox(
                widthFactor: 1.13,
                child: Image.asset(
                  'assets/images/payment_screen.png',
                  fit: BoxFit.cover,
                ),
              ),
              Gaps.vGap16,
              BlocConsumer<ReserveCubit, ReserveState>(
                listener: (context, reserveState) {
                  if (reserveState is ReserveSuccess) {
                    CustomAlert().showAlertDialog(
                      context: context,
                      isDismissible: true,
                      image: 'assets/gifs/done.gif',
                      title: 'success'.tr,
                      subTitle: 'booking_done'.tr,
                      btnTitle: 'reservations',
                      color: colors.main,
                      onpress: () {
                        Navigator.pop(context);
                        BlocProvider.of<BottomNavBarCubit>(context)
                            .changeCurrentScreen(index: 1);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.mainPageRoute,
                          (route) => false,
                        );
                      },
                    );
                  }
                },
                builder: (context, reserveState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (reserveState is ReserveError) ...[
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
                      (reserveState is ReserveLoading)
                          ? Center(
                              child: LoadingView(
                              bgColor: colors.secondary,
                              width: ScreenUtil().screenWidth - 20,
                            ))
                          : MyDefaultButton(
                              onPressed: () {
                                BlocProvider.of<ReserveCubit>(context)
                                    .fReserve(params);
                              },
                              btnText: 'pay',
                              color: colors.secondary,
                            ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
