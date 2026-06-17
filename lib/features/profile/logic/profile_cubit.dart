import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_system/core/network/dio_factory.dart';
import 'package:super_system/core/utils/storage_service.dart';
import 'package:super_system/features/profile/logic/profile_states.dart';
import 'package:super_system/features/profile/model/profile_data.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());

  void loadProfile({String? generalAverage}) {
    final storage = StorageService();
    final studentName = storage.getString(StorageService.keyStudentName);
    final groupName = storage.getString(StorageService.keyGroupName);
    final studentCode = storage.getString(StorageService.keyStudentCode);
    final parentPhone = storage.getString(StorageService.keyParentPhone);

    final subtitle = groupName.isNotEmpty ? 'طالب - $groupName' : 'طالب';

    emit(
      ProfileLoaded(
        ProfileData(
          studentName: studentName,
          subtitle: subtitle,
          studentCode: studentCode,
          generalAverage: generalAverage ?? '',
          guardianName: studentName.isNotEmpty ? 'ولي أمر $studentName' : 'ولي الأمر',
          guardianRelation: 'ولي الأمر',
          parentPhone: parentPhone,
        ),
      ),
    );
  }

  Future<void> logout() async {
    final storage = StorageService();
    await storage.clearSecure();
    await storage.remove(StorageService.keyStudentName);
    await storage.remove(StorageService.keyStudentCode);
    await storage.remove(StorageService.keyGroupName);
    await storage.remove(StorageService.keyParentPhone);
    await storage.remove(StorageService.keyAcademicYear);
    await storage.remove(StorageService.keySavedAccounts);
    await DioFactory.addDioHeaders();
    emit(ProfileLoggedOut());
  }
}
