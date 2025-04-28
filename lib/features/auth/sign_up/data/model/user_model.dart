class UserModel {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final String address;
  final String userType;

  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.userType,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
      'userType': userType,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      userType: json['userType'],
    );
  }
}
