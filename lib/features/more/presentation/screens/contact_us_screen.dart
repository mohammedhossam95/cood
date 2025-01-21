import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/values/svg_manager.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/core/widgets/tags_text_form_field.dart';
import '/injection_container.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode textFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    bool isRtl = AppLocalizations.of(context)!.isArLocale;
    return Scaffold(
      backgroundColor: colors.upBackGround,
      appBar: AppBar(
        title: Container(
          width: ScreenUtil().screenWidth,
          alignment: isRtl ? Alignment.centerLeft : Alignment.centerRight,
          child: Text('contact_us'.tr),
        ),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.vGap20,
              Text(
                'do_you_need_help'.tr,
                style: TextStyles.regular14(color: colors.main),
              ),
              Gaps.vGap20,
              AppTextFormField(
                controller: usernameController,
                focusNode: usernameFocusNode,
                hintText: 'إسم المستخدم',
                borderColor: colors.dividerColor,
              ),
              Gaps.vGap20,
              AppTextFormField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  hintText: 'البريد الألكتروني'),
              Gaps.vGap20,
              AppTextFormField(
                  controller: textController,
                  focusNode: textFocusNode,
                  hintText: 'شارك آرائك او اطلب المساعدة',
                  maxLines: 5),
              Gaps.vGap20,
              MyDefaultButton(
                onPressed: () {},
                btnText: 'send',
                svgAsset: SvgAssets.mail,
                textColor: colors.upBackGround,
              ),
              Gaps.vGap16,
              Row(
                children: [
                  const Expanded(
                      child: Divider(
                    thickness: 1,
                    color: Color(0xffC4C4C4),
                  )),
                  Gaps.hGap4,
                  Text(
                    'or'.tr,
                    style: TextStyles.regular14(color: const Color(0xffC4C4C4)),
                  ),
                  Gaps.hGap4,
                  const Expanded(
                      child: Divider(thickness: 1, color: Color(0xffC4C4C4))),
                ],
              ),
              Gaps.vGap16,
              MyDefaultButton(
                onPressed: () {},
                btnText: 'contact_us',
                svgAsset: SvgAssets.headphone,
                textColor: colors.upBackGround,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
