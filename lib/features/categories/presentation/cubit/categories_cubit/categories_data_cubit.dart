import 'package:bloc/bloc.dart';
import 'package:cood/features/categories/data/model/reservation_data.dart';
import 'package:cood/features/categories/presentation/cubit/categories_cubit/categories_state.dart';



class CategoriesDataCubit extends Cubit<CategoriesState> {
  CategoriesDataCubit() : super(CategoriesInitial());

  String? fromBranch;
  String? toBranch;
  String? startTime;
  String? endTime;
  String? startDate;
  String? endDate;
  String planType = 'Daily';
  String? coupon;

  saveCategoriesData() async {
    // sharedPreferences.saveReservasionData(
    //   ReservasionData(
    //     planType: planType,
    //     fromBranch: fromBranch!,
    //     startTime: startTime!,
    //     endTime: endTime!,
    //     startDate: startDate!,
    //     endDate: endDate,
    //     toBranch: toBranch,
    //     promocodeName: coupon,
    //   ),
    // );
  }

  removeCategoriesData() {
    // sharedPreferences.removeReservasionData();
    fromBranch = null;
    toBranch = null;
    startTime = null;
    endTime = null;
    startDate = null;
    endDate = null;
    coupon = null;
  }

  ReservasionData getCategoriesData() {
    // return sharedPreferences.getReservasionData();
    return ReservasionData(
      planType: planType,
      fromBranch: fromBranch!,
      startTime: startTime!,
      endTime: endTime!,
      startDate: startDate!,
      endDate: endDate,
      toBranch: toBranch,
      promocodeName: coupon,
    );
  }

  bool checkData() {
    if (fromBranch == null ||
        startDate == null ||
        startTime == null ||
        endTime == null) {
      return false;
    } else {
      return true;
    }
  }
}
