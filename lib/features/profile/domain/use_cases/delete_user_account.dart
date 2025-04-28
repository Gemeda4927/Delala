import 'package:delala/features/profile/domain/Repo/ProfileRepository.dart';

class DeleteUserAccount {
  final ProfileRepository repository;

  DeleteUserAccount(this.repository);

  Future<void> call() async {
    await repository.deleteUserAccount();
  }
}
