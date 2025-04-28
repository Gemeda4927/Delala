import 'package:delala/features/profile/domain/use_cases/update_user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delala/features/profile/domain/use_cases/delete_user_account.dart';
import 'package:delala/features/profile/domain/use_cases/get_user_profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfile getUserProfile;
  final UpdateUserProfile updateUserProfile;
  final DeleteUserAccount deleteUserAccount;

  ProfileBloc({
    required this.getUserProfile,
    required this.updateUserProfile,
    required this.deleteUserAccount,
  }) : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await getUserProfile();
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError('Failed to fetch profile: $e'));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final updatedProfile = await updateUserProfile(event.profile);
        emit(ProfileLoaded(updatedProfile));
      } catch (e) {
        emit(ProfileError('Failed to update profile: $e'));
      }
    });

    on<DeleteAccount>((event, emit) async {
      emit(ProfileLoading());
      try {
        await deleteUserAccount();
        emit(AccountDeleted());
      } catch (e) {
        emit(ProfileError('Failed to delete account: $e'));
      }
    });
  }
}
