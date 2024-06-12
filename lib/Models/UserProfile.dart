/// A class representing a User Profile with various attributes.
class UserProfile {
  /// The business name associated with the user.
  String businessName;

  /// The business address associated with the user.
  String businessAddress;

  /// The phone number of the user.
  String phoneNumber;

  /// The email address of the user.
  String email;

  /// Constructs a UserProfile instance.
  ///
  /// The [businessName], [businessAddress], [phoneNumber], and [email] parameters are optional and default to empty strings.
  UserProfile({
    this.businessName = '',
    this.businessAddress = '',
    this.phoneNumber = '',
    this.email = '',
  });
}
