import 'package:super_system/features/notifications/models/notifications_model.dart';

sealed class NotificationsStates {}

final class NotificationsInitial extends NotificationsStates {}

final class NotificationsLoading extends NotificationsStates {}

final class NotificationsSuccess extends NotificationsStates {
  final NotificationsModel data;
  NotificationsSuccess({required this.data});
}

final class NotificationsFailure extends NotificationsStates {
  final String message;
  NotificationsFailure({required this.message});
}
