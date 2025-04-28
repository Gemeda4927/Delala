class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String? password;
  final String phoneNumber;
  final String address;
  final String? profilePic;
  final String userType;
  final String userStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    this.password,
    required this.phoneNumber,
    required this.address,
    this.profilePic,
    required this.userType,
    required this.userStatus,
    required this.createdAt,
    required this.updatedAt,
  });
}
