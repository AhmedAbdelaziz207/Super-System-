import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_system/core/utils/storage_service.dart';
import 'package:super_system/features/notifications/logic/notifications_repo.dart';
import 'package:super_system/features/notifications/logic/notifications_states.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  final NotificationsRepo _notificationsRepo;

  NotificationsCubit(this._notificationsRepo) : super(NotificationsInitial());

  Future<void> getNotifications() async {
    emit(NotificationsLoading());
    try {
      final token = await StorageService().getSecure(StorageService.keyUserToken) ?? '';
      final response = await _notificationsRepo.getNotifications(token);

      if (response.status == 'success') {
        emit(NotificationsSuccess(data: response));
      } else {
        emit(NotificationsFailure(message: 'فشل جلب التنبيهات'));
      }
    } catch (e) {
      emit(NotificationsFailure(message: e.toString()));
    }
  }
}
