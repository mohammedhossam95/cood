// ignore_for_file: file_names
import 'package:equatable/equatable.dart';

import '/core/base_classes/base_list_response.dart';

class GetBrandsState extends Equatable {
  const GetBrandsState();

  @override
  List<Object> get props => [];
}

final class GetBrandsInitial extends GetBrandsState {}

final class GetBrandsLoading extends GetBrandsState {
  final bool isLoading;
  const GetBrandsLoading({required this.isLoading});
}

final class GetBrandsSuccess extends GetBrandsState {
  final BaseListResponse response;
  const GetBrandsSuccess({required this.response});
}

final class GetBrandsError extends GetBrandsState {
  final String message;
  const GetBrandsError({required this.message});
}
