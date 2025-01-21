import 'dart:developer';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '/config/locale/app_localizations.dart';
import '/core/params/car_params.dart';
import '/core/utils/constants.dart';
import '/core/utils/values/svg_manager.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/core/widgets/tags_text_form_field.dart';
import '/injection_container.dart';

final today = DateUtils.dateOnly(DateTime.now());

class DateRange extends StatefulWidget {
  const DateRange({super.key});

  @override
  State<DateRange> createState() => _DateRangeState();
}

class _DateRangeState extends State<DateRange> {
  final TextEditingController pickupDateController = TextEditingController();
  final TextEditingController deliveryDateController = TextEditingController();
  final FocusNode pickupDateFocusNode = FocusNode();
  final FocusNode deliveryDateFocusNode = FocusNode();
  final TextEditingController pickupTimeController = TextEditingController();
  final TextEditingController deliveryTimeController = TextEditingController();
  final FocusNode pickupTimeFocusNode = FocusNode();
  final FocusNode deliveryTimeFocusNode = FocusNode();

  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [null, null];

  String fromTime = '';
  String toTime = '';

  @override
  Widget build(BuildContext context) {
    bool isRtl = AppLocalizations.of(context)!.isArLocale;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: ScreenUtil().screenWidth,
          alignment: isRtl ? Alignment.centerLeft : Alignment.centerRight,
          child: Text('pickup_and_delivery_date_time'.tr),
        ),
        elevation: 4,
      ),
      body: _buildScrollRangeDatePickerWithValue(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
        child: Row(
          children: [
            Expanded(
              child: MyDefaultButton(
                  color: colors.buttonColor2,
                  textColor: colors.main,
                  onPressed: () {
                    setState(() {
                      _rangeDatePickerValueWithDefaultValue = [null, null];
                      pickupDateController.clear();
                      deliveryDateController.clear();
                      pickupTimeController.clear();
                      deliveryTimeController.clear();
                    });
                  },
                  btnText: 'reset'),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: MyDefaultButton(
                  onPressed: () {
                    final selectedDates = _rangeDatePickerValueWithDefaultValue;
                    if (selectedDates.isNotEmpty &&
                        selectedDates[0] != null &&
                        pickupTimeController.text.isNotEmpty &&
                        deliveryTimeController.text.isNotEmpty) {
                      final startDate = selectedDates[0];
                      final endDate =
                          selectedDates.length > 1 ? selectedDates[1] : null;
                      Navigator.pop(
                          context,
                          CarParams(
                            recerveDataFrom:
                                '${startDate?.day}-${startDate?.month}-${startDate?.year} $fromTime',
                            recerveDataTo:
                                '${endDate?.day}-${endDate?.month}-${endDate?.year} $toTime',
                          ));
                    } else {
                      Constants.showSnakToast(
                          context: context,
                          message: 'please_select_date_and_time'.tr,
                          type: 2);
                    }
                  },
                  btnText: 'confirm'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller,
      {bool isFrom = true}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        final now = DateTime.now();
        final dateTime =
            DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        final formattedTime = DateFormat('HH:mm', 'en').format(dateTime);
        controller.text = formattedTime;
        if (isFrom == true) {
          fromTime = DateFormat('hh:mm:ss a', 'en').format(dateTime);
        } else {
          toTime = DateFormat('hh:mm:ss a', 'en').format(dateTime);
        }
      });
    }
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : '';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        log(values.first.toString());
        final startDate =
            DateFormat("dd/MM/yyyy").format(values[0] ?? DateTime.now());
        final end = values.length > 1 ? values[1] : values[0];
        final endDate = DateFormat("dd/MM/yyyy").format(end ?? DateTime.now());
        valueText = '$startDate to $endDate';
        pickupDateController.text = startDate;
        deliveryDateController.text = endDate;
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  Widget _buildScrollRangeDatePickerWithValue() {
    final now = DateTime.now();
    // final firstDayOfNextMonth = DateTime(now.year, now.month + 2, 1);
    final lastDate = DateTime(now.year + 1);
    final hintDate = DateFormat("dd/MM/yyyy").format(now);
    final hintTime = DateFormat('HH:mm', 'en').format(now);
    final config = CalendarDatePicker2Config(
      currentDate: now,
      firstDate: now,
      lastDate: lastDate, // Limit to two full months
      // centerAlignModePicker: true,
      calendarType: CalendarDatePicker2Type.range,
      calendarViewMode: CalendarDatePicker2Mode.scroll,
      rangeBidirectional: true,
      selectedDayHighlightColor: colors.main,
      weekdayLabelTextStyle: TextStyles.medium12(
        color: colors.main,
      ),
      controlsTextStyle: TextStyles.regular14(
        color: colors.main,
      ),
      dynamicCalendarRows: true,
      weekdayLabels: [
        'Sun'.tr,
        'Mon'.tr,
        'Tue'.tr,
        'Wed'.tr,
        'Thu'.tr,
        'Fri'.tr,
        'Sat'.tr
      ],
      weekdayLabelBuilder: ({required weekday, isScrollViewTopHeader}) {
        // Ensure top header is empty
        if (isScrollViewTopHeader == true) {
          return const SizedBox.shrink(); // Remove the top header
        }
        return null;
      },
      modePickerTextHandler: ({required monthDate, isMonthPicker}) {
        if (isMonthPicker ?? false) {
          return '${getLocaleShortMonthFormat(const Locale('en')).format(monthDate)} New';
        }
        return null;
      },
      dayTextStyle: TextStyles.regular14(
        color: colors.main,
      ),

      disabledDayTextStyle:
          const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
      selectableDayPredicate: (day) {
        return true; // Allow picking any day
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        dayWidget = Container(
          decoration: decoration,
          child: Center(
            child: Text(
              MaterialLocalizations.of(context).formatDecimal(date.day),
              style: textStyle,
            ),
          ),
        );

        return dayWidget;
      },
    );

    return Padding(
      padding: EdgeInsets.all(25.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'pickup_date'.tr,
            style: TextStyles.regular14(color: colors.lightTextColor),
          ),
          Gaps.vGap8,
          SizedBox(
            height: 50.r,
            child: Row(
              children: [
                Expanded(
                  child: AppTextFormField(
                    readOnly: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.0.r),
                      child: SvgPicture.asset(
                        SvgAssets.calenderIcon,
                      ),
                    ),
                    controller: pickupDateController,
                    focusNode: pickupDateFocusNode,
                    hintText: hintDate,
                  ),
                ),
                Gaps.hGap20,
                Expanded(
                  child: AppTextFormField(
                    readOnly: true,
                    onTap: () => _selectTime(context, pickupTimeController),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.0.r),
                      child: SvgPicture.asset(
                        SvgAssets.clock,
                      ),
                    ),
                    controller: pickupTimeController,
                    focusNode: pickupTimeFocusNode,
                    hintText: hintTime,
                  ),
                ),
              ],
            ),
          ),
          Gaps.vGap16,
          Text(
            'delivery_date_time'.tr,
            style: TextStyles.regular14(color: colors.lightTextColor),
          ),
          Gaps.vGap8,
          SizedBox(
            height: 50.r,
            child: Row(
              children: [
                Expanded(
                  child: AppTextFormField(
                    readOnly: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.0.r),
                      child: SvgPicture.asset(
                        SvgAssets.calenderIcon,
                      ),
                    ),
                    controller: deliveryDateController,
                    focusNode: deliveryDateFocusNode,
                    hintText: hintDate,
                  ),
                ),
                Gaps.hGap20,
                Expanded(
                  child: AppTextFormField(
                    readOnly: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.0.r),
                      child: SvgPicture.asset(
                        SvgAssets.clock,
                      ),
                    ),
                    onTap: () => _selectTime(context, deliveryTimeController,
                        isFrom: false),
                    controller: deliveryTimeController,
                    focusNode: deliveryTimeFocusNode,
                    hintText: hintTime,
                  ),
                ),
              ],
            ),
          ),
          Gaps.vGap8,
          Divider(
            thickness: 1,
            color: colors.dividerColor,
          ),
          Expanded(
            child: CalendarDatePicker2(
              config: config,
              value: _rangeDatePickerValueWithDefaultValue,
              onValueChanged: (dates) {
                setState(() => _rangeDatePickerValueWithDefaultValue = dates);
                _getValueText(
                  config.calendarType,
                  _rangeDatePickerValueWithDefaultValue,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
