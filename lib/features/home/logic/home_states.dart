import 'package:super_system/features/absences_requests/model/execuse_model.dart';
import 'package:super_system/features/home/model/home_response.dart';

sealed class HomeStates {}

final class HomeInitial extends HomeStates {}

final class HomeLoading extends HomeStates {}

final class HomeSuccess extends HomeStates {
  final HomeResponse data;
  final ExecuseModel? absenceRequests;

  HomeSuccess({required this.data, this.absenceRequests});
}

final class HomeFailure extends HomeStates {
  final String message;
  HomeFailure({required this.message});
}
