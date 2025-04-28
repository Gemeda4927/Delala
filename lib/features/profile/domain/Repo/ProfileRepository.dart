import '../entities/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getUserProfile();
  Future<UserProfile> updateUserProfile(UserProfile profile);
  Future<void> deleteUserAccount();
}
