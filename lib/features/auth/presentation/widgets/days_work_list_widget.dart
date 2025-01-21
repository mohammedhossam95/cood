import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/values/text_styles.dart';
import '/features/auth/presentation/cubit/selected_days_cubit.dart';
import '/injection_container.dart';

class DaysWorkList extends StatelessWidget {
  const DaysWorkList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionDaysCubit, List<int>>(
      builder: (context, selectedItems) {
        return SizedBox(
          height: 40.h,
          child: ListView.builder(
            itemCount: 7,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              bool isSelected = selectedItems.contains(index);

              return GestureDetector(
                onTap: () {
                  context.read<SelectionDaysCubit>().toggleSelection(index);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: colors.buttonColor2),
                    color: isSelected ? colors.main : colors.baseColor,
                  ),
                  child: Center(
                    child: Text(
                      (context.read<SelectionDaysCubit>().daysValues[index]).tr,
                      style: TextStyles.regular16(
                        color:
                            isSelected ? colors.baseColor : colors.blackColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
