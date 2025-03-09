import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/values/img_manager.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/features/tabbar/presentation/cubit/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import '/injection_container.dart';

class NoCategoriess extends StatelessWidget {
  const NoCategoriess({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageAssets.noReservations),
          Gaps.vGap12,
          Text(
            'no_reservations'.tr,
            style: TextStyles.regular20(color: colors.main),
          ),
          Gaps.vGap32,
          MyDefaultButton(
            btnText: 'home',
            onPressed: () {
              BlocProvider.of<BottomNavBarCubit>(context)
                  .changeCurrentScreen(index: 0);
            },
            color: colors.secondary,
          ),
        ],
      ),
    );
  }
}
