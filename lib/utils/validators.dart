// lib/utils/validators.dart

/// A utility class to handle various form validations.
class Validators {
  /// Validates an email address based on simple criteria.
  /// Returns `true` if the email is valid, otherwise `false`.
  static bool isValidEmail(String email) {
    return email.isNotEmpty && email.contains('@');
  }
}
