import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/features/reservations/presentation/widgets/my_progress.dart';
import '../../../../../core/utils/values/text_styles.dart';
import '../../../../../injection_container.dart';
import '../../domain/entity/reservation_entity.dart';

class ReservationContainer extends StatelessWidget {
  const ReservationContainer({super.key, required this.getReservation});
  final GetReservation getReservation;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 12.w,
      ),
      decoration: BoxDecoration(
          color: colors.upBackGround,
          border: Border.all(color: colors.textColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(15.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appLocalizations.isArLocale
                          ? getReservation.car!.carImages?.brandNameAr ?? ''
                          : getReservation.car!.carImages?.brandNameEn ?? '',
                      style: TextStyles.bold20(),
                    ),
                    Text(
                      '(${getReservation.car!.carImages?.modelNameAr ?? 0000})',
                      style: TextStyles.bold16(),
                    ),
                    //StatusOrderItem(status: car.isAvailable ?? false)
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${"ReservationNumber".tr} ${getReservation.id ?? 0000}',
                        style: TextStyles.medium16(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${'branch'.tr} ${appLocalizations.isArLocale ? getReservation.fromBranch!.nameAr ?? '' : getReservation.fromBranch!.nameEn ?? ''}",
                        style: TextStyles.regular13(),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${"from".tr} ${getReservation.fromDate ?? 00}',
                  style: TextStyles.medium16(),
                ),
                Text(
                  '${"to".tr} ${getReservation.toDate ?? 00}',
                  style: TextStyles.medium16(),
                ),
                Text(
                  '${"rentTotal".tr} ${getReservation.finalPrice ?? 00} ${"reyal".tr}',
                  style: TextStyles.medium16(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text("${car.category!.nameAr}"),
                    Transform(
                      transform: Matrix4.identity()
                        ..setEntry(2, 1, 0.001)
                        ..rotateX(0.001),
                      alignment: FractionalOffset.center,
                      child: CachedNetworkImage(
                        imageUrl:
                            getReservation.car!.carImages?.images?.first ?? '',
                        height: 100.h,
                        fit: BoxFit.fitHeight,
                        errorWidget: (context, url, error) => Icon(
                          Icons.warning_amber_rounded,
                          size: 20.r,
                        ),
                        placeholder: (context, url) => MyProgrees(size: 25.r),
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
}
