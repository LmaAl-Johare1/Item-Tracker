/// A utility class for performing various validation checks.
class Validators {
  /// Validates an email address.
  ///
  /// [email] - The email address to validate.
  ///
  /// Returns true if the email is valid; otherwise, false.
  static bool validateEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  /// Validates a password.
  ///
  /// [password] - The password to validate.
  ///
  /// Returns true if the password meets the validation criteria; otherwise, false.
  /// The criteria are:
  /// - At least 6 characters long.
  /// - Contains at least one uppercase letter.
  /// - Contains at least one lowercase letter.
  /// - Contains at least one number.
  static bool validatePassword(String password) {
    final RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$');
    return passwordRegex.hasMatch(password);
  }

  /// Validates whether two passwords match.
  ///
  /// [password] - The first password.
  /// [confirmPassword] - The password to compare with the first password.
  ///
  /// Returns true if both passwords match; otherwise, false.
  static bool validatePasswordMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  /// Checks if a field is empty or contains only whitespace.
  ///
  /// [field] - The field to check.
  ///
  /// Returns true if the field is empty or contains only whitespace; otherwise, false.
  static bool isFieldEmpty(String field) {
    return field.trim().isEmpty;
  }

  /// Checks if a field is null or empty.
  ///
  /// [field] - The field to check.
  ///
  /// Returns true if the field is null or empty; otherwise, false.
  static bool isFieldEmptyOrNull(String? field) {
    return field == null || field.trim().isEmpty;
  }
}
