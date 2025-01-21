import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/utils/enums.dart';
import '/core/utils/values/assets.dart';
import '../../config/locale/app_localizations.dart';
import '../../config/routes/app_routes.dart';
import '../../injection_container.dart';
import '../utils/app_strings.dart';
import '../utils/values/gif_manager.dart';
import '../utils/values/strings.dart';
import '../utils/values/svg_manager.dart';
import 'app_elevated_button.dart';

class ErrorText extends StatefulWidget {
  final String? text;
  final bool isNetwork;
  final double? height;
  final double width;
  final MyError search;
  final EdgeInsetsGeometry? margin;

  const ErrorText(
      {super.key,
      required this.width,
      this.text,
      this.isNetwork = false,
      this.height,
      this.search = MyError.defaultError,
      this.margin});

  @override
  State<ErrorText> createState() => _ErrorTextState();
}

class _ErrorTextState extends State<ErrorText> {
  @override
  Widget build(BuildContext context) {
    return widget.isNetwork
        ? Scaffold(body: SafeArea(child: _builContainer(context, widget.width)))
        : _builContainer(context, widget.width);
  }

  _builContainer(BuildContext context, width) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: widget.margin ?? const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.65,
            height: width * 0.65,
            child: Image.asset(
              widget.isNetwork
                  ? SvgAssets.userNetworkError
                  : errorImage(widget.search, context),
            ),
          ),
          SizedBox(height: 10.h),
          AutoSizeText(
            widget.text == AppStrings.unAuthorizedFailure
                ? Strings.welcomeToAppMessage
                : '${widget.text}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: colors.errorColor,
                  fontSize: 18.sp,
                ),
          ),
          SizedBox(height: 10.h),
          if (widget.text == AppStrings.unAuthorizedFailure)
            AppElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, Routes.loginScreenRoute, (route) => false),
              text: Strings.login,
            ),
        ],
      ),
    );
  }

  String errorImage(MyError type, BuildContext context) {
    switch (type) {
      case MyError.saerch:
        return GifAssets.noUser;

      default:
        return ImgAssets.imagesNoData;
    }
  }
}

class FixedError extends StatelessWidget {
  const FixedError({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var background = Colors.red;
    var icon = ImgAssets.imagesWarning;
    var textColor = colors.upBackGround;
    var iconColor = colors.upBackGround;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: background,
      ),
      height: MediaQuery.of(context).size.height * 0.07,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              icon,
              width: 25,
              color: iconColor,
            ),
          ),
          SizedBox(
              width: width * 0.7,
              child: Text(
                AppLocalizations.of(context)!.text('noData'),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 16, color: textColor),
                maxLines: 2,
              )),
        ],
      ),
    );
  }
}
