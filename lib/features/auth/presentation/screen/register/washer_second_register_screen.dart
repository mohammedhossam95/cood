import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/widgets/my_default_button.dart';
import '/features/auth/presentation/screen/register/new_user_register_screen.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../core/utils/values/text_styles.dart';
import '../../../../../core/widgets/gaps.dart';
import '../../../../../core/widgets/tags_text_form_field.dart';
import '../../../../../injection_container.dart';
import '../../../domain/usecases/landery_register_use_case.dart';

class WasherRegisterSecondScreen extends StatefulWidget {
  const WasherRegisterSecondScreen({super.key});

  @override
  State<WasherRegisterSecondScreen> createState() =>
      _WasherRegisterSecondScreenState();
}

class _WasherRegisterSecondScreenState
    extends State<WasherRegisterSecondScreen> {
  final GlobalKey<FormState> formState = GlobalKey();
  final TextEditingController descriptionArController = TextEditingController();
  final FocusNode descriptionArFocus = FocusNode();
  final TextEditingController descriptionEnController = TextEditingController();
  final FocusNode descriptionEnFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    LanderyRegisterParams dataParams =
        ModalRoute.of(context)!.settings.arguments as LanderyRegisterParams;
    return Scaffold(
      backgroundColor: colors.baseColor,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'new_register'.tr,
          style: TextStyles.regular16(),
        ),
      ),
      body: Form(
        key: formState,
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AmrLinearProgressIndecatorWidget(
                  linearValue: 1 / 2,
                ),
                Gaps.vGap20,
                AmrTheFristMessageRegisterWidget(
                  itemTitel: 'second_step'.tr,
                  itemSubTitel: 'wacher_second_step_detials'.tr,
                ),
                Gaps.vGap40,
                Text(
                  'wacher_descreption_AR'.tr,
                  style: TextStyles.bold16(),
                ),
                Gaps.vGap15,
                AppTextFormField(
                  controller: descriptionArController,
                  focusNode: descriptionArFocus,
                  hintText: 'wacher_descreption_AR'.tr,
                  maxLines: 5,
                  textInputAction: TextInputAction.next,
                  validatorType: ValidatorType.standard,
                ),
                Gaps.vGap40,
                Text(
                  'washer_description_EN'.tr,
                  style: TextStyles.bold16(),
                ),
                Gaps.vGap15,
                AppTextFormField(
                  controller: descriptionEnController,
                  focusNode: descriptionEnFocus,
                  hintText: 'washer_description_EN'.tr,
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  validatorType: ValidatorType.standard,
                ),
                SizedBox(
                  height: ScreenUtil().screenHeight * .2,
                ),
                MyDefaultButton(
                  onPressed: () {
                    if (formState.currentState!.validate()) {
                      formState.currentState!.save();

                      Navigator.pushNamed(
                          context, Routes.newWasherRegisterTheardStepRoute,
                          arguments: LanderyRegisterParams(
                            userName: dataParams.userName,
                            phone: dataParams.phone,
                            email: dataParams.email,
                            descreptionAR: descriptionArController.text,
                            descreptionEN: descriptionEnController.text,
                          ));
                    }
                  },
                  btnText: 'next',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
