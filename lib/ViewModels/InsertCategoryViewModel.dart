import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Services/network_service.dart';

class CategoryViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();

  String? _imagePath;
  String? _CategoryName;

  String? get imagePath => _imagePath;
  String? get CategoryName => _CategoryName;

  void updateImagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }

  void updateCategoryName(String name) {
    _CategoryName = name;
    notifyListeners();
  }

  Future<void> saveCategory() async {
    Map<String, dynamic> data = {
      'imagePath': _imagePath,
      'CategoryName': _CategoryName,
    };

    try {
      await NetworkService().sendData('Categories', data);
      resetFields();
      print('Category inserted successfully');
    } catch (error) {
      print('Failed to insert Category: $error');
    }
  }
  /// Reset all fields to their initial values.
  void resetFields() {
    _imagePath = null;
    _CategoryName = null;
    notifyListeners();
  }
}
