import 'package:flutter/material.dart';

import '/config/locale/app_localizations.dart';
import '/injection_container.dart';
import '../../../../core/utils/values/text_styles.dart';

class SummaryDetailsTable extends StatelessWidget {
  const SummaryDetailsTable({super.key, required this.tableData});

  final List tableData;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          decoration: BoxDecoration(color: colors.main),
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'item'.tr,
                  style: TextStyles.bold16(color: colors.upBackGround),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'quantity'.tr,
                  style: TextStyles.bold16(color: colors.upBackGround),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'discount'.tr,
                  style: TextStyles.bold16(color: colors.upBackGround),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'total'.tr,
                  style: TextStyles.bold16(color: colors.upBackGround),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        ...tableData.map(
          (e) => _reusableTabeleRow(
              label: '${e.title}',
              count: '${e.count}',
              total: '${e.total}',
              value: '${e.value}'),
        ),
      ],
    );
  }

  TableRow _reusableTabeleRow({
    required String label,
    required String value,
    required total,
    required count,
  }) {
    return TableRow(
      children: [
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
              child: Text(
            label,
            style: TextStyles.bold16(),
            textAlign: TextAlign.center,
          )),
        )),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Center(
            child: Text(
              count,
              style: TextStyles.bold16(),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Center(
            child: Text(
              value,
              style: TextStyles.bold16(),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Center(
            child: Text(
              total,
              style: TextStyles.bold16(),
            ),
          ),
        ),
      ],
    );
  }
}
