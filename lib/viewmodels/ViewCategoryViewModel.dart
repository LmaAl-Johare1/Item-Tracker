import 'package:flutter/material.dart';

import '../Models/Category.dart';
import '../Services/network_service.dart';

class CategoryViewModel with ChangeNotifier {
  List<Category> _categories = [];
  List<Category> _filteredCategories = [];
  String? _errorMessage;

  List<Category> get categories => _categories;
  List<Category> get filteredCategories => _filteredCategories.isEmpty ? _categories : _filteredCategories;
  String? get errorMessage => _errorMessage;

  void filterCategories(String query) {
    if (query.isEmpty) {
      _filteredCategories = [];
    } else {
      _filteredCategories = _categories.where((category) {
        return category.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    try {
      final List<Map<String, dynamic>> data = await NetworkService().fetchAll('Categories');
      _categories = data.map((json) => Category.fromJson(json)).toList();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load categories. Please try again later.";
      print(e.toString()); // For debugging purposes
    }
    notifyListeners();
  }
}
