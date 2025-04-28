class User {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final String address;
  final String userType;

  User({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.userType,
  });

  static fromJson(Map<String, dynamic> json) {}
}