import 'package:super_system/features/absences_requests/model/execuse_model.dart';

sealed class AbsenceRequestStates {}

class AbsenceRequestInitial extends AbsenceRequestStates {}

class AbsenceRequestLoading extends AbsenceRequestStates {}

class AbsenceRequestSuccess extends AbsenceRequestStates {
  final ExecuseModel data;

  AbsenceRequestSuccess(this.data);
}

class AbsenceRequestFailure extends AbsenceRequestStates {
  final String message;

  AbsenceRequestFailure(this.message);
}
