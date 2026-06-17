import 'package:super_system/features/profile/model/profile_data.dart';

sealed class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class ProfileLoaded extends ProfileStates {
  final ProfileData data;

  ProfileLoaded(this.data);
}

class ProfileLoggedOut extends ProfileStates {}
