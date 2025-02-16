import 'package:cood/core/utils/values/app_colors.dart';
import 'package:cood/features/home/domain/entities/social_entity.dart';
import 'package:cood/features/home/presentation/widgets/social_container_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/params/car_params.dart';
import '/core/utils/log_utils.dart';
import '/core/utils/values/text_styles.dart';
import '/core/widgets/gaps.dart';
import '/core/widgets/my_default_button.dart';
import '/features/home/domain/entities/plans_status_entity.dart';
import '/features/home/presentation/cubit/get_plans_status_cubit/get_plans_status_cubit.dart';
import '/features/home/presentation/widgets/cities_list.dart';
import '/injection_container.dart';
import '../../../../config/routes/app_routes.dart';

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
  //-------------------------------------------ali
  List<Color> socialPhotoColors = [
    MyColors.main,
    MyColors.socialGreen,
    MyColors.black,
    MyColors.socialyellow,
  ];
  List<Color> socialBacgroundColors = [
    MyColors.facbookItemColor,
    MyColors.whatsAppItemColor,
    MyColors.tikokItemColor,
    MyColors.snapShatItemColor,
  ];

  List<SocialEntity> sociaEntityModel = [
    SocialEntity(
        name: 'Andrew Tate',
        email: 'Andrewtate25235@hotmail.com',
        image: 'assets/images/facbook.png'),
    SocialEntity(
        name: 'Andrew Tate',
        email: '+966599697364',
        image: 'assets/images/Whatsapp 1.png'),
    SocialEntity(
        name: '@AndrewTate',
        email: 'Andrewtate@hotmail.com',
        image: 'assets/images/tiktok.png'),
    SocialEntity(
        name: '@AndrewTate',
        email: 'Andrewtate@hotmail.com',
        image: 'assets/images/snapchat.png'),
  ];

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
                Gaps.vGap20,
                //----------1
                // const HomeAppBar(), //no touch
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Center(
                        child: Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: colors.main,
                            border: Border.all(
                              color: colors.main,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.asset(
                              "assets/images/user.jpeg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Gaps.hGap10,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'فهد سليمان',
                              style: TextStyles.regular15(),
                            ),
                            Text(
                              '359698845',
                              style: TextStyles.regular12(),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications,
                          color: colors.main,
                          size: 30.r,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.settingScreenRoute);
                        },
                        icon: Icon(
                          Icons.settings,
                          color: colors.main,
                          size: 30.r,
                        ),
                      ),
                    ],
                  ),
                ),
                //----------2
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                ),
                //--------3
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0.w),
                  height: 420.h,
                  decoration: BoxDecoration(
                    color: MyColors.upBackGround,
                    borderRadius: BorderRadius.circular(25.r),
                    boxShadow: [
                      BoxShadow(
                        color:
                            MyColors.body.withValues(alpha: .5), // Shadow color
                        spreadRadius: 2.r, // Spread radius
                        blurRadius: 10.r, // Blur radius
                        offset: Offset(0, 3), // Offset in x and y directions
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        sociaEntityModel.length,
                        (index) => SocialContainerItem(
                          entityModel: sociaEntityModel[index],
                          socialPhotoColors: socialPhotoColors[index],
                          socialBackgroundColors: socialBacgroundColors[index],
                        ),
                      ),
                    ),
                  ),
                ),
                Gaps.vGap12,
                //-----------------4
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10.h),
                        child: MyDefaultButton(
                          onPressed: () {},
                          height: 50.h,
                          btnText: "link_other_accounts",
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10.h),
                        child: MyDefaultButton(
                          onPressed: () {},
                          height: 50.h,
                          btnText: "communication_channels",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
            color:
                isSelected ? colors.main : colors.main.withValues(alpha: .12),
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
