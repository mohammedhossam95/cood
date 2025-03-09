part of 'coupon_validation_cubit.dart';

abstract class CouponValidationState extends Equatable {
  const CouponValidationState();

  @override
  List<Object?> get props => <Object?>[];
}

class CouponValidationInitial extends CouponValidationState {
  const CouponValidationInitial();
}

class CouponValidationLoading extends CouponValidationState {
  final bool isLoading;
  const CouponValidationLoading(this.isLoading);
}

class CouponValidationSuccess extends CouponValidationState {
  final BaseOneResponse response;
  const CouponValidationSuccess({required this.response});
}

class CouponValidationError extends CouponValidationState {
  final String message;
  const CouponValidationError({required this.message});
}
