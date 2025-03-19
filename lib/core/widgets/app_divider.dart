// ignore_for_file: must_be_immutable

import 'package:cood/core/utils/values/app_colors.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  double? width; 
  double? height;
  Color? color;
  AppDivider({super.key,this.width=100,this.height=1,this.color=MyColors.main,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}
