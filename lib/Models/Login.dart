/// A model class representing login credentials.
///
/// This class encapsulates the email and password required for logging in.
/// Both email and password are required parameters in the constructor.
class LoginModel {
  /// The email address associated with the user's account.
  final String email;

  /// The password associated with the user's account.
  final String password;

  /// Creates a new [LoginModel] instance with the provided [email] and [password].
  ///
  /// Both [email] and [password] parameters are required.
  LoginModel({required this.email, required this.password});
}