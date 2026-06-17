import 'package:super_system/features/finance/model/finance_model.dart';

sealed class FinanceStates {}

final class FinanceInitial extends FinanceStates {}

final class FinanceLoading extends FinanceStates {}

final class FinanceSuccess extends FinanceStates {
  final FinanceModel data;
  FinanceSuccess({required this.data});
}

final class FinanceFailure extends FinanceStates {
  final String message;
  FinanceFailure({required this.message});
}
