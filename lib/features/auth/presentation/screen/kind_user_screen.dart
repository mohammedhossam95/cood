import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/features/language/presentation/cubit/locale_cubit/locale_cubit.dart';
import '/injection_container.dart';

class KindUserScreen extends StatefulWidget {
  const KindUserScreen({super.key});

  @override
  State<KindUserScreen> createState() => _KindUserScreenState();
}

class _KindUserScreenState extends State<KindUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: colors.upBackGround,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BlocConsumer<LocaleCubit, LocaleState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Container(
                      // margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(5.0),
                      //   color: Colors.white,
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Colors.grey,
                      //       offset: Offset(0.0, 0.5), //(x,y)
                      //       blurRadius: 6.0,
                      //     ),
                      //   ],),
                      alignment: state.locale.languageCode == 'ar'
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Container(
                        width: 106.w,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colors.secondryColor,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.welcomeRoute);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.language,
                                color: colors.main,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                state.locale.languageCode == 'ar'
                                    ? 'arabic'.tr
                                    : 'english'.tr,
                                style: TextStyles.bold12(color: colors.main),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Gaps.vGap95,
              Text(
                'welcometo'.tr,
                style: TextStyles.bold24(color: colors.main),
                textAlign: TextAlign.right,
              ),
              Gaps.vGap10,
              Text(
                'jzlrentalcar'.tr,
                style: TextStyles.medium17(color: colors.main),
                textAlign: TextAlign.right,
              ),
              Gaps.vGap45,
              MyDefaultButton(
                color: colors.secondary,
                borderColor: colors.secondary,
                textColor: colors.upBackGround,
                btnText: 'startNow',
                onPressed: () {
                  Navigator.pushNamed(context, Routes.loginScreenRoute);
                },
              ),
              Gaps.vGap25,
              MyDefaultButton(
                color: colors.secondryColor,
                borderColor: colors.secondryColor,
                textColor: colors.main,
                btnText: 'continueAsGuest',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.mainPageRoute,
                    (route) => false,
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
