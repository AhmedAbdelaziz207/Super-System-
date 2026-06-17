import 'package:super_system/features/attendence/model/attendence_model.dart';

sealed class AttendenceStates {}

final class AttendenceInitial extends AttendenceStates {}

final class AttendenceLoading extends AttendenceStates {}

final class AttendenceSuccess extends AttendenceStates {
  final AttendenceModel data;
  AttendenceSuccess({required this.data});
}

final class AttendenceFailure extends AttendenceStates {
  final String message;
  AttendenceFailure({required this.message});
}
