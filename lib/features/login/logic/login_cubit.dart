import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_system/core/network/dio_factory.dart';
import 'package:super_system/core/utils/storage_service.dart';
import 'package:super_system/features/login/logic/login_repo.dart';
import 'package:super_system/features/login/logic/login_states.dart';
import 'package:super_system/features/login/model/login_request_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginRepo _loginRepo;
  
  LoginCubit(this._loginRepo) : super(LoginInitial());

  Future<void> emitLogin({required String studentCode, required String password}) async {
    emit(LoginLoading());
    try {
      final request = LoginRequestModel(
        studentCode: studentCode,
        parentPassword: password,
        deviceId: 'device-uuid-123', // TODO: Get actual device info
        fcmToken: 'fcm-token-xyz', // TODO: Get actual FCM token
        platform: 'android', // TODO: Get actual platform
        deviceName: 'Mobile Device', // TODO: Get actual device name
        appVersion: '1.0.0', // TODO: Get actual app version
        notificationsStatus: 'enabled',
        app: 'super',
      );
      
      final response = await _loginRepo.login(request);
      
      if (response.status == 'success') {
        // Save token and set in Dio
        if (response.parentToken != null) {
          await StorageService().saveSecure(StorageService.keyUserToken, response.parentToken!);
          DioFactory.setTokenIntoHeaderAfterLogin(response.parentToken!);
        }
        if (response.refreshToken != null) {
          await StorageService().saveSecure(StorageService.keyRefreshToken, response.refreshToken!);
        }
        
        // Cache student data
        if (response.student != null) {
          await StorageService().save(StorageService.keyStudentName, response.student!.studentName ?? '');
          await StorageService().save(StorageService.keyStudentCode, response.student!.studentCode ?? '');
          await StorageService().save(StorageService.keyParentPhone, response.student!.parentPhone ?? '');
          await StorageService().save(StorageService.keyAcademicYear, response.student!.academicYear ?? '');
        }
        if (response.group != null) {
          await StorageService().save(StorageService.keyGroupName, response.group!.groupName ?? '');
        }

        // Add account to the saved accounts list
        await StorageService().saveCurrentAccountToList();

        emit(LoginSuccess(message: response.message ?? 'تم تسجيل الدخول بنجاح'));
      } else {
        emit(LoginFailure(message: response.message ?? 'فشل تسجيل الدخول'));
      }
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }
}