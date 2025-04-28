class UserProfileModel {
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

  UserProfileModel({
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

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      profilePic: json['profilePic'] as String?,
      userType: json['userType'] as String,
      userStatus: json['userStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        if (profilePic != null) 'profilePic': profilePic,
      };
}
