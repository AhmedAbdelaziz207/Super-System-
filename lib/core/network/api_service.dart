import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_system/core/network/api_endpoints.dart';
import 'package:super_system/features/attendence/model/attendence_model.dart';
import 'package:super_system/features/exams/model/exams_results_model.dart';
import 'package:super_system/features/absences_requests/model/execuse_model.dart';
import 'package:super_system/features/finance/model/finance_model.dart';
import 'package:super_system/features/home/model/home_response.dart';
import 'package:super_system/features/login/model/login_response_model.dart';
import 'package:super_system/features/notifications/models/notifications_model.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiEndpoints.login)
  Future<LoginResponseModel> login(@Body() FormData request);

  @GET(ApiEndpoints.home)
  Future<HomeResponse> getHomeStatistics(@Query('parent_token') String token);

  @GET(ApiEndpoints.notifications)
  Future<NotificationsModel> getNotifications(
    @Query('parent_token') String token,
  );

  @GET(ApiEndpoints.attendence)
  Future<AttendenceModel> getAttendence(
    @Query('parent_token') String token,
    @Query('month') int month,
    @Query('year') int year,
    @Query('type') String absenceType,
  );

  @GET(ApiEndpoints.examsResults)
  Future<ExamsResultsModel> getExamsResults(
    @Query('parent_token') String token, {
    @Query('filter') String filter = "all",
  });

  @GET(ApiEndpoints.getMonthlyExpenses)
  Future<FinanceModel> getMonthlyExpenses(
    @Query('parent_token') String token,
    @Query('year') int year,
  );
  @GET(ApiEndpoints.getExecuse)
  Future<ExecuseModel> getAbsenceRequests(
    @Query('parent_token') String token,
    @Query('month') int month,
    @Query('year') int year,
  );

  // Form is -> parent_token , device_name , app_version, notifications_status
  @POST(ApiEndpoints.updateDevice)
  Future<void> updateDevice(@Body() FormData formData);

  // parent_token
  @POST(ApiEndpoints.updateLastSeen)
  Future<void> updateLastSeen(@Body() FormData formData);

  // Form is -> refresh_token
  @POST(ApiEndpoints.updateParentToken)
  Future<LoginResponseModel> updateParentToken(@Body() FormData refreshToken);

  // Form is -> parent_token , fcm_token
  @POST(ApiEndpoints.fcmToken)
  Future<void> updateFCM(@Body() FormData formData);
}
