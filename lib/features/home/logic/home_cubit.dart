import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_system/core/network/dio_factory.dart';
import 'package:super_system/core/utils/storage_service.dart';
import 'package:super_system/features/absences_requests/logic/absence_request_repo.dart';
import 'package:super_system/features/absences_requests/model/execuse_model.dart';
import 'package:super_system/features/home/logic/home_repo.dart';
import 'package:super_system/features/home/logic/home_states.dart';
import 'package:super_system/features/home/model/home_response.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeRepo _homeRepo;
  final AbsenceRequestRepo _absenceRequestRepo;

  HomeCubit(this._homeRepo, this._absenceRequestRepo) : super(HomeInitial());

  Future<void> getHomeStatistics() async {
    if (isClosed) return;
    emit(HomeLoading());
    try {
      String token =
          await StorageService().getSecure(StorageService.keyUserToken) ?? '';
      final now = DateTime.now();

      HomeResponse response;
      try {
        response = await _homeRepo.getHomeStatistics(token);
      } catch (e) {
        final errorStr = e.toString().toLowerCase();
        if (errorStr.contains('unauthenticated') ||
            errorStr.contains('token') ||
            errorStr.contains('expire') ||
            errorStr.contains('403') ||
            errorStr.contains('401') ||
            errorStr.contains('forbidden') ||
            errorStr.contains('unauthorized')) {
          final refreshToken =
              await StorageService().getSecure(
                StorageService.keyRefreshToken,
              ) ??
              '';
          if (refreshToken.isNotEmpty) {
            try {
              final loginResponse = await _homeRepo.updateParentToken(
                refreshToken,
              );
              if (loginResponse.status == 'success' &&
                  loginResponse.parentToken != null) {
                token = loginResponse.parentToken ?? token;
                await StorageService().saveSecure(
                  StorageService.keyUserToken,
                  token,
                );
                DioFactory.setTokenIntoHeaderAfterLogin(token);
                if (loginResponse.refreshToken != null) {
                  await StorageService().saveSecure(
                    StorageService.keyRefreshToken,
                    loginResponse.refreshToken!,
                  );
                }
                response = await _homeRepo.getHomeStatistics(token);
              } else {
                throw Exception(e.toString());
              }
            } catch (_) {
              throw Exception(e.toString());
            }
          } else {
            throw Exception(e.toString());
          }
        } else {
          throw Exception(e.toString());
        }
      }

      ExecuseModel? absenceRequests;

      try {
        final absenceResponse = await _absenceRequestRepo.getAbsenceRequests(
          token: token,
          month: now.month,
          year: now.year,
        );
        if (absenceResponse.status == 'success') {
          absenceRequests = absenceResponse;
        }
      } catch (_) {
        absenceRequests = null;
      }

      if (isClosed) return;
      if (response.status == 'success') {
        emit(HomeSuccess(data: response, absenceRequests: absenceRequests));
      } else {
        emit(HomeFailure(message: 'فشل جلب البيانات'));
      }
    } catch (e) {
      if (!isClosed) emit(HomeFailure(message: e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> updateDevice({
    required String deviceName,
    required String appVersion,
    required String notificationsStatus,
  }) async {
    try {
      final token =
          await StorageService().getSecure(StorageService.keyUserToken) ?? '';
      await _homeRepo.updateDevice(
        token: token,
        deviceName: deviceName,
        appVersion: appVersion,
        notificationsStatus: notificationsStatus,
      );
    } catch (e) {
      // Handle quietly
    }
  }

  Future<void> updateLastSeen() async {
    try {
      final token =
          await StorageService().getSecure(StorageService.keyUserToken) ?? '';
      await _homeRepo.updateLastSeen(token);
    } catch (e) {
      // Handle quietly
    }
  }

  Future<void> updateFCM(String fcmToken) async {
    try {
      final token =
          await StorageService().getSecure(StorageService.keyUserToken) ?? '';
      await _homeRepo.updateFCM(token: token, fcmToken: fcmToken);
    } catch (e) {
      // Handle quietly
    }
  }
}
