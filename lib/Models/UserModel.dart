class UserModel {
  String businessName;
  String businessAddress;
  String phoneNumber;
  String email;
  String role;

  UserModel({
    required this.businessName,
    required this.businessAddress,
    required this.phoneNumber,
    required this.email,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      businessName: data['businessName'] ?? '',
      businessAddress: data['businessAddress'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'admin',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'businessName': businessName,
      'businessAddress': businessAddress,
      'phoneNumber': phoneNumber,
      'email': email,
      'role': role,
    };
  }
}
