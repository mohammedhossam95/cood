import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/values/text_styles.dart';
import '/injection_container.dart';

class CalnederScreem extends StatefulWidget {
  const CalnederScreem({
    super.key,
  });

  @override
  State<CalnederScreem> createState() => _CalnederScreemState();
}

class _CalnederScreemState extends State<CalnederScreem> {
  DateRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'pickup_and_delivery_date_time'.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: 576,
                  child: DateRangePickerWidget(
                    displayMonthsSeparator: true,
                    doubleMonth: true,
                    initialDateRange: selectedDateRange,
                    maximumDateRangeLength: 30,
                    minimumDateRangeLength: 3,
                    // disabledDates: [DateTime(2023, 11, 20)],
                    initialDisplayedDate: DateTime.now(),
                    onDateRangeChanged: print,
                    theme: CalendarTheme(
                      selectedColor: colors.main,
                      dayNameTextStyle:
                          const TextStyle(color: Colors.black45, fontSize: 10),
                      inRangeColor: const Color(0xFFD9EDFA),
                      inRangeTextStyle: TextStyle(color: colors.main),
                      selectedTextStyle:
                          TextStyles.regular14(color: Colors.white),
                      todayTextStyle: TextStyles.bold14(),
                      defaultTextStyle: TextStyles.regular12(),
                      radius: 10,
                      tileSize: 40,
                      disabledTextStyle: const TextStyle(color: Colors.grey),
                      quickDateRangeBackgroundColor: const Color(0xFFFFF9F9),
                      selectedQuickDateRangeColor: colors.main,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("The month selector:"),
                SizedBox(
                  width: 450,
                  child: MonthSelectorAndDoubleIndicator(
                    currentMonth: DateTime(2023, 11, 20),
                    onNext: () => debugPrint("Next"),
                    onPrevious: () => debugPrint("Previous"),
                    nextMonth: DateTime(2023, 12, 20),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("A button to open the picker:"),
                TextButton(
                  onPressed: () => showDateRangePickerDialog(
                      context: context, builder: datePickerBuilder),
                  child: const Text("Open the picker"),
                ),
                const SizedBox(height: 20),
                const Text("The quick dateRanges:"),
                SizedBox(
                  width: 250,
                  height: 100,
                  child: QuickSelectorWidget(
                      selectedDateRange: selectedDateRange,
                      quickDateRanges: [
                        QuickDateRange(
                          label: 'Last 3 days',
                          dateRange: DateRange(
                            DateTime.now().subtract(const Duration(days: 3)),
                            DateTime.now(),
                          ),
                        ),
                        QuickDateRange(
                          label: 'Last 7 days',
                          dateRange: DateRange(
                            DateTime.now().subtract(const Duration(days: 7)),
                            DateTime.now(),
                          ),
                        ),
                        QuickDateRange(
                          label: 'Last 30 days',
                          dateRange: DateRange(
                            DateTime.now().subtract(const Duration(days: 30)),
                            DateTime.now(),
                          ),
                        ),
                        QuickDateRange(
                          label: 'Last 90 days',
                          dateRange: DateRange(
                            DateTime.now().subtract(const Duration(days: 90)),
                            DateTime.now(),
                          ),
                        ),
                        QuickDateRange(
                          label: 'Last 180 days',
                          dateRange: DateRange(
                            DateTime.now().subtract(const Duration(days: 180)),
                            DateTime.now(),
                          ),
                        ),
                      ],
                      onDateRangeChanged: print,
                      theme: kTheme),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget datePickerBuilder(
          BuildContext context, dynamic Function(DateRange?) onDateRangeChanged,
          [bool doubleMonth = true]) =>
      DateRangePickerWidget(
        doubleMonth: doubleMonth,
        maximumDateRangeLength: 10,
        quickDateRanges: [
          QuickDateRange(dateRange: null, label: "Remove date range"),
          QuickDateRange(
            label: 'Last 3 days',
            dateRange: DateRange(
              DateTime.now().subtract(const Duration(days: 3)),
              DateTime.now(),
            ),
          ),
          QuickDateRange(
            label: 'Last 7 days',
            dateRange: DateRange(
              DateTime.now().subtract(const Duration(days: 7)),
              DateTime.now(),
            ),
          ),
          QuickDateRange(
            label: 'Last 30 days',
            dateRange: DateRange(
              DateTime.now().subtract(const Duration(days: 30)),
              DateTime.now(),
            ),
          ),
          QuickDateRange(
            label: 'Last 90 days',
            dateRange: DateRange(
              DateTime.now().subtract(const Duration(days: 90)),
              DateTime.now(),
            ),
          ),
          QuickDateRange(
            label: 'Last 180 days',
            dateRange: DateRange(
              DateTime.now().subtract(const Duration(days: 180)),
              DateTime.now(),
            ),
          ),
        ],
        minimumDateRangeLength: 3,
        initialDateRange: selectedDateRange,
        disabledDates: [DateTime(2023, 11, 20)],
        initialDisplayedDate:
            selectedDateRange?.start ?? DateTime(2023, 11, 20),
        onDateRangeChanged: onDateRangeChanged,
        height: 350,
        theme: const CalendarTheme(
          selectedColor: Colors.blue,
          dayNameTextStyle: TextStyle(color: Colors.black45, fontSize: 10),
          inRangeColor: Color(0xFFD9EDFA),
          inRangeTextStyle: TextStyle(color: Colors.blue),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayTextStyle: TextStyle(fontWeight: FontWeight.bold),
          defaultTextStyle: TextStyle(color: Colors.black, fontSize: 12),
          radius: 10,
          tileSize: 40,
          disabledTextStyle: TextStyle(color: Colors.grey),
          quickDateRangeBackgroundColor: Color(0xFFFFF9F9),
          selectedQuickDateRangeColor: Colors.blue,
        ),
      );
}
