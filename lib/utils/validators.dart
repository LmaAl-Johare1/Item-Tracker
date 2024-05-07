class Validator {
  /// Validates an email address.
  ///
  /// Returns true if the email is valid; otherwise, false.
  static bool validateEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }


  /// Validates a password.
  ///
  /// Returns true if the password meets the validation criteria; otherwise, false.
  static bool validatePassword(String password) {
    return password.length >= 6;
  }

  /// Validates whether two passwords match.
  ///
  /// Returns true if both passwords match; otherwise, false.
  static bool validatePasswordMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }
  /// Validates a phone number.
  ///
  /// Returns true if the phone number is valid; otherwise, false.
  static bool validatePhoneNumber(String phoneNumber) {

    final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
    return phoneRegex.hasMatch(phoneNumber);
  }
  /// Checks if a field is empty.
  ///
  /// Returns true if the field is empty or contains only whitespace; otherwise, false.
  static bool isFieldEmpty(String field) {
    return field.trim().isEmpty;
  }
}
