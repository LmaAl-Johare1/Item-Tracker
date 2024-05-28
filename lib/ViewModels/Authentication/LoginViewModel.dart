/*import '../../../services/network_service.dart';
import '../../models/login.dart';

/// A view model class responsible for handling login operations.
class LoginViewModel {
  final NetworkService _networkService = NetworkService();

  /// Logs in the user using the provided [loginData].
  ///
  /// This method fetches user data from the network service and compares it with
  /// the provided login credentials. If the credentials match, it prints a success message.
  /// Otherwise, it prints an error message indicating incorrect credentials.
  ///
  /// Throws an error if an exception occurs during the login process.
  Future<void> login(LoginModel loginData) async {
    try {
      final userData = await _networkService.fetchData('Users', loginData.email);

      if (userData["email"] == loginData.email && userData['password'] == loginData.password) {
        print('You have been logged in successfully');
      } else {
        print('Error: The username or password is incorrect');
      }
    } catch (e) {
      print('An error occurred while logging in: $e');
    }
  }
}*/