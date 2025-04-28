import 'package:delala/features/profile/domain/Repo/ProfileRepository.dart';

import '../entities/user_profile.dart';

class UpdateUserProfile {
  final ProfileRepository repository;

  UpdateUserProfile(this.repository);

  Future<UserProfile> call(UserProfile profile) async {
    return await repository.updateUserProfile(profile);
  }
}
