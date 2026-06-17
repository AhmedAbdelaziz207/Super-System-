import 'package:super_system/features/exams/model/exams_results_model.dart';

sealed class ExamsStates {}

final class ExamsInitial extends ExamsStates {}

final class ExamsLoading extends ExamsStates {}

final class ExamsSuccess extends ExamsStates {
  final ExamsResultsModel data;
  ExamsSuccess({required this.data});
}

final class ExamsFailure extends ExamsStates {
  final String message;
  ExamsFailure({required this.message});
}
