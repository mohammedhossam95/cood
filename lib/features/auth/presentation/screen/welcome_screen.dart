import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/widgets/gaps.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/exit_app_dialog.dart';
import '../../../../core/widgets/show_dialog.dart';
import '../../../../injection_container.dart';
import '../../../language/presentation/cubit/locale_cubit/locale_cubit.dart';
import '../cubit/auto_login/auto_login_cubit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late LanguageCode languageValue;

  @override
  void initState() {
    super.initState();
    context.read<AutoLoginCubit>().saveUserCycle(type: UserCycle.login);
    languageValue = context.read<LocaleCubit>().currentLangCode;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (value, result) async {
        await showAppDialog(
              context: context,
              child: const ExitAppDialog(),
            ) ??
            false;
      },
      child: Scaffold(
        backgroundColor: colors.upBackGround,
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gaps.vGap50,
              Center(
                child: Text(
                  AppLocalizations.of(context)!.text('choose_language'),
                  style: TextStyles.bold18(),
                ),
              ),
              Gaps.vGap20,
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          languageValue = LanguageCode.ar;
                        });
                      },
                      child: Card(
                        elevation: 0,
                        color: colors.unselected.withOpacity(0.1),
                        surfaceTintColor: colors.unselected.withOpacity(0.1),
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          width: 120.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: languageValue == LanguageCode.ar
                                  ? colors.main
                                  : colors.unselected,
                              width: 2,
                            ),
                            color: colors.unselected.withOpacity(0.1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Padding(
                              //   padding: EdgeInsets.symmetric(horizontal: 8.w),
                              //   child: Image.asset(ImgAssets.imagesLogoAr),
                              // ),
                              Gaps.vGap12,
                              Text(
                                'arabic'.tr,
                                style: TextStyles.bold17(),
                              ),
                              Gaps.vGap12,
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          languageValue = LanguageCode.en;
                        });
                      },
                      child: Card(
                        elevation: 0,
                        color: colors.unselected.withOpacity(0.1),
                        surfaceTintColor: colors.unselected.withOpacity(0.1),
                        child: Container(
                          // height: 100.h,
                          padding: EdgeInsets.all(8.r),
                          width: 120.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              width: 2,
                              color: languageValue == LanguageCode.en
                                  ? colors.main
                                  : colors.unselected,
                            ),
                            color: colors.unselected.withOpacity(0.1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Padding(
                              //   padding: EdgeInsets.symmetric(horizontal: 8.w),
                              //   child: ClipRRect(
                              //     borderRadius: BorderRadius.circular(100.r),
                              //     child: Image.asset(ImgAssets.usaFlagImage),
                              //   ),
                              // ),
                              Gaps.vGap12,
                              Text(
                                'english'.tr,
                                style: TextStyles.bold17(),
                              ),
                              Gaps.vGap12,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.vGap30,
              Text(
                'يمكنك أيضا تغير اللغة من قائمة لإعدادات',
                style: TextStyles.bold15(),
              ),
              Text(
                '"You can change language from settings "',
                style: TextStyles.bold15(),
              ),
              Gaps.vGap60,
              BlocListener<LocaleCubit, LocaleState>(
                listener: (context, state) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.loginScreenRoute,
                    (route) => false,
                  );
                },
                child: Container(
                  width: 120.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: colors.main),
                  child: TextButton(
                    onPressed: () {
                      context
                          .read<LocaleCubit>()
                          .changeLanguage(languageValue, context);
                    },
                    child: Text(
                      'next'.tr,
                      style: TextStyles.bold16(color: colors.baseColor),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
