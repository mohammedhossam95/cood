import 'package:flutter/material.dart';

import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/gaps.dart';
import '../../../../injection_container.dart';

class ReusableBranchContainer extends StatelessWidget {
  const ReusableBranchContainer(
      {super.key,
      required this.type,
      required this.date,
      required this.time,
      required this.branch});
  final String type, date, time, branch;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: TextStyles.bold16(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.location_city, color: colors.main),
            Gaps.hGap4,
            Expanded(
              child: Text(
                branch,
                style: TextStyles.regular12(
                    color: colors.textColor.withValues(alpha: 0.5)),
              ),
            ),
          ],
        ),
        Gaps.vGap8,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.calendar_month, color: colors.main),
            Gaps.hGap4,
            Expanded(
              child: Text(
                date + time,
                style: TextStyles.regular12(
                    color: colors.textColor.withValues(alpha: 0.5)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
