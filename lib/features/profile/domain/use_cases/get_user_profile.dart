import 'package:delala/features/profile/domain/Repo/ProfileRepository.dart';

import '../entities/user_profile.dart';

class GetUserProfile {
  final ProfileRepository repository;

  GetUserProfile(this.repository);

  Future<UserProfile> call() async {
    return await repository.getUserProfile();
  }
}
