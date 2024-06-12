/// A class representing a User with various attributes.
class UserModel {
  /// The business name associated with the user.
  String businessName;

  /// The business address associated with the user.
  String businessAddress;

  /// The phone number of the user.
  String phoneNumber;

  /// The email address of the user.
  String email;

  /// The role of the user.
  String role;

  /// Constructs a UserModel instance.
  ///
  /// The [businessName], [businessAddress], [phoneNumber], [email], and [role] parameters are required.
  UserModel({
    required this.businessName,
    required this.businessAddress,
    required this.phoneNumber,
    required this.email,
    required this.role,
  });

  /// Creates a UserModel instance from a Map object.
  ///
  /// The [data] parameter should be a Map<String, dynamic> containing the user data.
  /// Returns a UserModel instance with the data from the Map object.
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      businessName: data['businessName'] ?? '',
      businessAddress: data['businessAddress'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'admin',
    );
  }

  /// Converts the UserModel instance to a Map object.
  ///
  /// Returns a Map<String, dynamic> representing the user data.
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
