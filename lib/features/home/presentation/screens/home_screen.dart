import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/config/routes/app_routes.dart';
import '/core/params/car_params.dart';
import '/core/utils/constants.dart';
import '/core/utils/log_utils.dart';
import '/core/utils/validator.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/app_snack_bar.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/menu_text_form_field.dart';
import '/core/widgets/my_default_button.dart';
import '/features/home/domain/entities/plans_status_entity.dart';
import '/features/home/presentation/cubit/get_plans_status_cubit/get_plans_status_cubit.dart';
import '/features/home/presentation/screens/date_range.dart';
import '/features/home/presentation/widgets/cities_list.dart';
import '/features/home/presentation/widgets/home_app_bar.dart';
import '/features/home/presentation/widgets/home_gallery.dart';
import '/injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedDurationIndex = 0;
  int selectedLocationIndex = 0;
  bool isSelected = false;
  bool isSamePickupLocation = false;
  bool isDriverAgeAbove21 = false;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  TextEditingController cityController = TextEditingController();
  FocusNode cityFocusNode = FocusNode();
  int? cityId;
  CarParams result = const CarParams();
  CarParams carParams = const CarParams();
  @override
  void initState() {
    BlocProvider.of<GetPlansStatusCubit>(context).getPlansStatus();
    // BlocProvider.of<GetCitiesCubit>(context).getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TextTheme theme = Theme.of(context).textTheme;
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppBar(),
                const HomeGallery(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'rental_duration'.tr,
                        style: TextStyles.regular14(color: colors.main),
                      ),
                      Gaps.vGap12,
                      BlocBuilder<GetPlansStatusCubit, GetPlansStatusState>(
                        builder: (context, state) {
                          if (state is GetPlansStatusLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is GetPlansStatusSuccess) {
                            PlansStatusEntity plansStatus =
                                state.response.data as PlansStatusEntity;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                plansStatus.daily!
                                    ? _buildDurationOption('daily', 0)
                                    : const SizedBox.shrink(),
                                Gaps.hGap10,
                                plansStatus.weekly!
                                    ? _buildDurationOption('weekly', 1)
                                    : const SizedBox.shrink(),
                                Gaps.hGap10,
                                plansStatus.monthly!
                                    ? _buildDurationOption('monthly', 2)
                                    : const SizedBox.shrink(),
                              ],
                            );
                          } else if (state is GetPlansStatusError) {
                            return Center(child: Text(state.message));
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      Gaps.vGap12,
                      Text(
                        'selected_pickup_city'.tr,
                        style: TextStyles.regular14(color: colors.main),
                      ),
                      Gaps.vGap12,
                      InkWell(
                        onTap: () => showZipCodesSheet(),
                        child: MenuTextFormField(
                          controller: cityController,
                          focusNode: cityFocusNode,
                          onTap: () => showZipCodesSheet(),
                          validate: (value) => Validator.call(
                              value: value, type: ValidatorType.standard),
                          hintText: 'choose_your_city_pickup_location'.tr,
                        ),
                      ),
                      Gaps.vGap12,
                      InkWell(
                        onTap: () async {
                          result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DateRange()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: colors.main,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.white,
                              ),
                              Gaps.hGap10,
                              Text(
                                'pickup_return_date_time'.tr,
                                style:
                                    TextStyles.regular14(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap12,
                      // _buildCheckboxOption(
                      //   'return_to_same_location',
                      //   isSamePickupLocation,
                      //   (value) {
                      //     setState(() {
                      //       isSamePickupLocation = value ?? false;
                      //     });
                      //   },
                      // ),
                      _buildCheckboxOption(
                        'driver_age_21_and_above',
                        isDriverAgeAbove21,
                        (value) {
                          setState(() {
                            isDriverAgeAbove21 = value ?? false;
                          });
                        },
                      ),
                      Gaps.vGap30,
                      MyDefaultButton(
                        btnText: 'start_search',
                        onPressed: () {
                          carParams = carParams.copyWith(
                            recerveDataFrom: result.recerveDataFrom,
                            recerveDataTo: result.recerveDataTo,
                          );
                          if (carParams.recerveDataFrom == null ||
                              carParams.recerveDataTo == null ||
                              carParams.cityId == null ||
                              carParams.plan == null) {
                            showAppSnackBar(
                              context: context,
                              message:
                                  'please_make_sure_to_select_all_fields'.tr,
                              type: ToastType.info,
                            );
                          } else {
                            Navigator.pushNamed(context, Routes.carsScreenRoute,
                                arguments: carParams);
                          }
                        },
                        color: colors.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.h,
            left: 0,
            child: InkWell(
              onTap: () {
                String url =
                    'https://api.whatsapp.com/send/?phone=201093539408&text&type=phone_number&app_absent=0';

                Constants.launchAppUrl(url).onError(
                  (error, stackTrace) => Constants.showSnakToast(
                    context: context,
                    type: 3,
                    message: error.toString(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: colors.main,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'contact_us'.tr,
                    style: TextStyles.regular12(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildDurationOption(String text, int index) {
    final bool isSelected = index == selectedDurationIndex;
    carParams = carParams.copyWith(plan: 'DAILY');
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDurationIndex = index;
            if (index == 0) {
              carParams = carParams.copyWith(plan: 'DAILY');
            } else if (index == 1) {
              carParams = carParams.copyWith(plan: 'WEEKLY');
            } else if (index == 2) {
              carParams = carParams.copyWith(plan: 'MONTHLY');
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          decoration: BoxDecoration(
            color: isSelected ? colors.main : colors.main.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              text.tr,
              style: TextStyles.regular14(
                  color: isSelected ? Colors.white : colors.main),
            ),
          ),
        ),
      ),
    );
  }

  void showZipCodesSheet() {
    showModalBottomSheet(
        constraints:
            BoxConstraints(maxHeight: ScreenUtil().screenHeight * 0.75),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        context: context,
        builder: (context) => CitiesList(
              updateSelected: (value) {
                if (value != null) {
                  setState(() {
                    carParams = carParams.copyWith(cityId: value.id.toString());
                    carParams = carParams.copyWith(city: value);
                    Log.w(carParams.toString());
                    cityId = value.id;
                    cityController.text = value.nameAr ?? '';
                  });
                } else {
                  setState(() {
                    cityId = null;
                    cityController.clear();
                  });
                }
              },
            ));
  }

  Widget _buildCheckboxOption(
      String text, bool isSelected, Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(
            value: isSelected,
            onChanged: onChanged,
            checkColor: Colors.white,
            fillColor: WidgetStateProperty.all<Color>(
                isSelected ? colors.main : colors.upBackGround)),
        Text(
          text.tr,
          style: TextStyles.regular14(color: colors.main),
        ),
      ],
    );
  }
}
