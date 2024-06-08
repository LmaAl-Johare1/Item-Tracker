import 'package:flutter/material.dart';
import '../../Services/network_service.dart';

class CategoryViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();

  String? _imagePath;
  String? _name;
  String? _errorMessage;

  String? get imagePath => _imagePath;
  String? get name => _name;
  String? get errorMessage => _errorMessage;

  void updateImagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }

  void updateCategoryName(String name) {
    _name = name;
    _errorMessage = null; // Reset the error message when updating the name
    notifyListeners();
  }

  Future<void> saveCategory(BuildContext context) async {
    if (_name == null || _name!.isEmpty) {
      _errorMessage = "Please enter a valid category name";
      notifyListeners();
      return;
    }

    Map<String, dynamic> data = {
      'imagePath': _imagePath,
      'name': _name,
    };

    try {
      await _networkService.sendData('Categories', data);
      resetFields();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Category inserted successfully')),
      );
    } catch (error) {
      print('Failed to insert Category: $error');
    }
  }

  void resetFields() {
    _imagePath = null;
    _name = null;
    notifyListeners();
  }
}
