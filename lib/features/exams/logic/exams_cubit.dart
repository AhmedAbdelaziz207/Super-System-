import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_system/core/utils/storage_service.dart';
import 'package:super_system/features/exams/logic/exams_repo.dart';
import 'package:super_system/features/exams/logic/exams_states.dart';

class ExamsCubit extends Cubit<ExamsStates> {
  final ExamsRepo _examsRepo;

  ExamsCubit(this._examsRepo) : super(ExamsInitial());

  Future<void> getExamsResults() async {
    if (isClosed) return;
    emit(ExamsLoading());
    try {
      final token = await StorageService().getSecure(StorageService.keyUserToken) ?? '';
      final response = await _examsRepo.getExamsResults(token);

      if (isClosed) return;
      if (response.status == 'success') {
        emit(ExamsSuccess(data: response));
      } else {
        emit(ExamsFailure(message: 'فشل جلب نتائج الاختبارات'));
      }
    } catch (e) {
      if (!isClosed) emit(ExamsFailure(message: e.toString()));
    }
  }
}
