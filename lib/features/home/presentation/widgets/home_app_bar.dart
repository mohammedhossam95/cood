import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '/config/routes/app_routes.dart';
import '/core/utils/values/svg_manager.dart';
import '/injection_container.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: colors.main,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.profileScreenRoute);
              },
              child: SvgPicture.asset(SvgAssets.user)),
          SvgPicture.asset(SvgAssets.logo),
          SvgPicture.asset(SvgAssets.bell),
        ],
      ),
    );
  }
}
