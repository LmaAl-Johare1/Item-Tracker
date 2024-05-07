
import '../../models/user.dart';
import '../../services/network_service.dart';
import '../models/login.dart';

class LoginViewModel {
  final NetworkService _networkService = NetworkService();

  Future<void> login(LoginModel loginData) async {
    try {
      final userData = await _networkService.fetchData('Users', loginData.email);

      if (userData["email"]==loginData.email && userData['password'] == loginData.password) {
        print('You have been logged in successfully');
      } else {
        print('Error: The username or password is incorrect');
      }
    } catch (e) {
      print('An error occurred while logging in: $e');
    }
  }
}

