import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/gaps.dart';
import '../../../../injection_container.dart';
import '../cubit/categories_cubit/categories_cubit.dart';

List<String> planPeriod = ['1', '3', '6', '9'];
List<String> planTitle = [
  "economic",
  "mostBalanced",
  "mostDemanded",
  "superSaver",
];

class ReservationPlansContainer extends StatefulWidget {
  final List<int> offers;
  final List<int> text;
  final List<String> savings;
  const ReservationPlansContainer(
      {required this.offers,
      required this.text,
      required this.savings,
      super.key});

  @override
  State<ReservationPlansContainer> createState() =>
      _ReservationPlansContainerState();
}

class _ReservationPlansContainerState extends State<ReservationPlansContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          height: 160.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.offers.length,
            separatorBuilder: (context, index) => Gaps.hGap8,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                // context.read<CategoriesCubit>().total = 0;
                // context.read<CategoriesCubit>().changeSelectedIndex(
                //     index, context, widget.offers.cast<int>());
              },
              child: widget.offers[index] == 0
                  ? const SizedBox()
                  : SizedBox(
                      width: 120.w,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10.h,
                            child: Container(
                              height: 150.h,
                              width: 120.w,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              decoration: BoxDecoration(
                                  color:
                                      colors.unselected.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(
                                    // color: colors.main,
                                    color: colors.dividerColor,
                                    width: 2,
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        planPeriod[index],
                                        style: TextStyles.bold24(),
                                      ),
                                      Text('months'.tr),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.text[index].toString(),
                                        style: TextStyles.bold20(
                                            color: colors.main),
                                      ),
                                      if (widget.savings[index] == "0") ...[
                                        const Text("  "),
                                        Text(
                                          'reyal'.tr,
                                          style: TextStyles.regular13(
                                              color: colors.main),
                                        ),
                                      ]
                                    ],
                                  ),
                                  if (widget.savings[index] != "0")
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'reyal'.tr,
                                          style: TextStyles.regular13(
                                              color: colors.main),
                                        ),
                                        Text(' /${'monthly'.tr}',
                                            style: TextStyles.regular13(
                                                color: colors.main)),
                                      ],
                                    ),
                                  if (widget.savings[index] != "0")
                                    Text(
                                      "${'Save'.tr} ${widget.savings[index]} ${'reyal'.tr}",
                                      style: TextStyles.bold14(),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 20.w,
                            left: 20.w,
                            child: Container(
                              alignment: Alignment.center,
                              height: 20.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(
                                      color: colors.textColor
                                          .withValues(alpha: 0.6)),
                                  color: colors.upBackGround),
                              child: Text(planTitle[index].tr),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
