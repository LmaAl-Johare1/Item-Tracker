class Validator {
  /// Validates an email address.
  ///
  /// Returns true if the email is valid; otherwise, false.
  static bool validateEmail(String email) {
    // Basic email validation using a regular expression
    // You can customize the regular expression as per your requirements
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Validates a password.
  ///
  /// Returns true if the password meets the validation criteria; otherwise, false.
  static bool validatePassword(String password) {
    // Password validation criteria (e.g., minimum length)
    return password.length >= 6; // Example: Password should be at least 6 characters long
  }

  /// Validates whether two passwords match.
  ///
  /// Returns true if both passwords match; otherwise, false.
  static bool validatePasswordMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  /// Checks if a field is empty.
  ///
  /// Returns true if the field is empty or contains only whitespace; otherwise, false.
  static bool isFieldEmpty(String field) {
    return field.trim().isEmpty;
  }
}
