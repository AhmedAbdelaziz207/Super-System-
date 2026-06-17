sealed class LoginStates {}
final class LoginInitial extends LoginStates {}
final class LoginLoading extends LoginStates {}
final class LoginSuccess extends LoginStates {
  final String message;
  LoginSuccess({required this.message});
}
final class LoginFailure extends LoginStates {
  final String message;
  LoginFailure({required this.message});
}