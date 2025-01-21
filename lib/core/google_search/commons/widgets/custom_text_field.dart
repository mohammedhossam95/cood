import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Function(String) onChange;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    double myFontSize = 14.sp;
    double raduis = 24.r;
    return TextField(
      controller: controller,
      onChanged: onChange,
      style: theme.bodyMedium!.copyWith(
        color: colors.body,
        fontSize: myFontSize,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0x26B2B8B4),
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        hintStyle: theme.bodyMedium!.copyWith(
          color: colors.body,
          fontSize: myFontSize,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(raduis)),
          borderSide: BorderSide(
            color: colors.borderColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(raduis)),
          borderSide: BorderSide(
            color: colors.borderColor,
            width: 1.0,
          ),
        ),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                onPressed: () {
                  controller.text = '';
                },
              )
            : null,
        border: InputBorder.none,
      ),
    );
  }
}
