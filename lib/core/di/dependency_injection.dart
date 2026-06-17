import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:super_system/core/network/api_service.dart';
import 'package:super_system/core/network/dio_factory.dart';
import 'package:super_system/features/home/logic/home_cubit.dart';
import 'package:super_system/features/home/logic/home_repo.dart';
import 'package:super_system/features/login/logic/login_repo.dart';
import 'package:super_system/features/notifications/logic/notifications_cubit.dart';
import 'package:super_system/features/notifications/logic/notifications_repo.dart';
import 'package:super_system/features/attendence/logic/attendence_cubit.dart';
import 'package:super_system/features/attendence/logic/attendence_repo.dart';
import 'package:super_system/features/exams/logic/exams_cubit.dart';
import 'package:super_system/features/exams/logic/exams_repo.dart';
import 'package:super_system/features/finance/logic/finance_cubit.dart';
import 'package:super_system/features/finance/logic/finance_repo.dart';
import 'package:super_system/features/absences_requests/logic/absence_request_cubit.dart';
import 'package:super_system/features/absences_requests/logic/absence_request_repo.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));

  // home
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt(), getIt()));

  // notifications
  getIt.registerLazySingleton<NotificationsRepo>(() => NotificationsRepo(getIt()));
  getIt.registerFactory<NotificationsCubit>(() => NotificationsCubit(getIt()));

  // attendance
  getIt.registerLazySingleton<AttendenceRepo>(() => AttendenceRepo(getIt()));
  getIt.registerFactory<AttendenceCubit>(() => AttendenceCubit(getIt()));

  // exams
  getIt.registerLazySingleton<ExamsRepo>(() => ExamsRepo(getIt()));
  getIt.registerFactory<ExamsCubit>(() => ExamsCubit(getIt()));

  // finance
  getIt.registerLazySingleton<FinanceRepo>(() => FinanceRepo(getIt()));
  getIt.registerFactory<FinanceCubit>(() => FinanceCubit(getIt()));

  // absence requests
  getIt.registerLazySingleton<AbsenceRequestRepo>(() => AbsenceRequestRepo(getIt()));
  getIt.registerFactory<AbsenceRequestCubit>(() => AbsenceRequestCubit(getIt()));
}
