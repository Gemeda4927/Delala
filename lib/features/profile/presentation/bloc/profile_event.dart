import 'package:delala/features/profile/domain/entities/user_profile.dart';

abstract class ProfileEvent {}

class FetchProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final UserProfile profile;
  UpdateProfile(this.profile);
}

class DeleteAccount extends ProfileEvent {}