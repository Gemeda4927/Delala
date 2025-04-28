import 'package:delala/core/handlers/dio_client.dart';
import 'package:delala/features/profile/data/model/UserProfile.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> updateUserProfile(UserProfileModel profile);
  Future<void> deleteUserAccount();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient dioClient;

  ProfileRemoteDataSourceImpl(this.dioClient);

  @override
  Future<UserProfileModel> getUserProfile() async {
    try {
      final response = await dioClient.dio.get(ApiConstants.profile);
      if (response.statusCode == 200) {
        return UserProfileModel.fromJson(response.data);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Failed to load profile: ${response.statusCode}',
      );
    } on DioException catch (e) {
      throw Exception('Failed to load profile: ${e.message}');
    }
  }

  @override
  Future<UserProfileModel> updateUserProfile(UserProfileModel profile) async {
    try {
      final response = await dioClient.dio.patch(
        ApiConstants.updateProfile,
        data: profile.toJson(),
      );
      if (response.statusCode == 200) {
        return UserProfileModel.fromJson(response.data);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Failed to update profile: ${response.statusCode}',
      );
    } on DioException catch (e) {
      throw Exception('Failed to update profile: ${e.message}');
    }
  }

  @override
  Future<void> deleteUserAccount() async {
    try {
      final response = await dioClient.dio.delete(ApiConstants.deleteAccount);
      if (response.statusCode != 200) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to delete account: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to delete account: ${e.message}');
    }
  }
}

class ApiConstants {
  static const String baseUrl = 'http://192.168.1.2:3000';
  static const String profile = '$baseUrl/users/profile';
  static const String updateProfile = '$baseUrl/users/update-profile';
  static const String deleteAccount = '$baseUrl/users/delete-account';
}
