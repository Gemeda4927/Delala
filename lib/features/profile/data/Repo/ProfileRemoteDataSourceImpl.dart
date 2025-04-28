import 'package:delala/features/profile/data/model/UserProfile.dart';
import 'package:delala/features/profile/data/service/profileService.dart';
import 'package:delala/features/profile/domain/Repo/ProfileRepository.dart';
import 'package:delala/features/profile/domain/entities/user_profile.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserProfile> getUserProfile() async {
    try {
      final model = await remoteDataSource.getUserProfile();
      return UserProfile(
        id: model.id,
        fullName: model.fullName,
        email: model.email,
        password: model.password,
        phoneNumber: model.phoneNumber,
        address: model.address,
        profilePic: model.profilePic,
        userType: model.userType,
        userStatus: model.userStatus,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
      );
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  @override
  Future<UserProfile> updateUserProfile(UserProfile profile) async {
    try {
      final model = UserProfileModel(
        id: profile.id,
        fullName: profile.fullName,
        email: profile.email,
        password: profile.password,
        phoneNumber: profile.phoneNumber,
        address: profile.address,
        profilePic: profile.profilePic,
        userType: profile.userType,
        userStatus: profile.userStatus,
        createdAt: profile.createdAt,
        updatedAt: profile.updatedAt,
      );
      final updatedModel = await remoteDataSource.updateUserProfile(model);
      return UserProfile(
        id: updatedModel.id,
        fullName: updatedModel.fullName,
        email: updatedModel.email,
        password: updatedModel.password,
        phoneNumber: updatedModel.phoneNumber,
        address: updatedModel.address,
        profilePic: updatedModel.profilePic,
        userType: updatedModel.userType,
        userStatus: updatedModel.userStatus,
        createdAt: updatedModel.createdAt,
        updatedAt: updatedModel.updatedAt,
      );
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  @override
  Future<void> deleteUserAccount() async {
    try {
      await remoteDataSource.deleteUserAccount();
    } catch (e) {
      throw Exception('Failed to delete user account: $e');
    }
  }
}
