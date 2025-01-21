import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/values/strings.dart';
import '../../../../core/utils/values/text_styles.dart';
import '../../../../injection_container.dart';
import '../../../../core/utils/values/svg_manager.dart';

class SelectGender extends StatefulWidget {
  final String currentGender;
  final ValueChanged<String>? updateView;

  const SelectGender({
    super.key,
    this.currentGender = 'male',
    this.updateView,
  });

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  String currentGender = 'male';

  @override
  void initState() {
    super.initState();
    currentGender = widget.currentGender;
  }

  _selectMale() {
    setState(() {
      currentGender = 'male';
      widget.updateView!(currentGender);
    });
  }

  _selectFemale() {
    setState(() {
      currentGender = 'female';
      widget.updateView!(currentGender);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _selectMale(),
            child: _buildComponent(
              text: Strings.male,
              iconSvg: SvgAssets.bell,
              isSelected: currentGender == 'male',
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: InkWell(
            onTap: () => _selectFemale(),
            child: _buildComponent(
              text: Strings.female,
              iconSvg: SvgAssets.bell,
              isSelected: currentGender == 'female',
            ),
          ),
        ),
      ],
    );
  }

  _buildComponent({
    required String text,
    required String iconSvg,
    required bool isSelected,
  }) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: isSelected ? colors.main.withOpacity(0.08) : colors.upBackGround,
        border: Border.all(
          width: 1,
          color: isSelected
              ? colors.main.withOpacity(0.5)
              : colors.body.withOpacity(0.25),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SvgPicture.asset(
              iconSvg,
              colorFilter: ColorFilter.mode(
                isSelected ? colors.main : colors.body,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyles.regular14(
              color: isSelected ? colors.main : colors.body,
            ),
          ),
        ],
      ),
    );
  }
}
