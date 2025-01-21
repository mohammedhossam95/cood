import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/utils/enums.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/features/language/presentation/cubit/locale_cubit/locale_cubit.dart';
import '/injection_container.dart';

class LanguageSettingWidget extends StatefulWidget {
  const LanguageSettingWidget({super.key});

  @override
  State<LanguageSettingWidget> createState() => _LanguageSettingWidgetState();
}

class _LanguageSettingWidgetState extends State<LanguageSettingWidget> {
  // late LanguageCode languageValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.r),
          topLeft: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox(
                width: 40.w,
                child: Divider(
                  thickness: 3.5.h,
                )),
          ),
          Gaps.vGap18,
          Text(
            'language'.tr,
            style: TextStyles.bold14(),
          ),
          Gaps.vGap18,
          const Divider(),
          BlocListener<LocaleCubit, LocaleState>(
            listener: (context, state) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.mainPageRoute,
                (route) => false,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyDefaultButton(
                    onPressed: () {
                      context
                          .read<LocaleCubit>()
                          .changeLanguage(LanguageCode.ar, context);
                    },
                    btnText: 'arabic',
                    color: colors.secondary,
                    borderColor: colors.buttonColor2,
                    textColor: colors.main,
                    width: 150.w,
                  ),
                  MyDefaultButton(
                    onPressed: () {
                      context
                          .read<LocaleCubit>()
                          .changeLanguage(LanguageCode.en, context);
                    },
                    btnText: 'english',
                    width: 150.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
