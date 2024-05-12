import 'package:flutter/material.dart';

import '../Models/Category.dart';
import '../Services/network_service.dart';

class CategoryViewModel with ChangeNotifier {
  List<Category> _categories = [];
  List<Category> _filteredCategories = [];  // Holds filtered categories
  String? _errorMessage;

  List<Category> get categories => _categories;
  List<Category> get filteredCategories => _filteredCategories.isEmpty ? _categories : _filteredCategories;
  String? get errorMessage => _errorMessage;

  void setCategories(List<Category> categories) {
    _filteredCategories = categories;
    _filteredCategories = List<Category>.from(categories);
    notifyListeners();
  }

  void filterCategories(String query) {
    print("Search query: $query"); // Log the query
    if (query.isEmpty) {
      _filteredCategories = List<Category>.from(_filteredCategories);
    } else {
      _filteredCategories = _filteredCategories.where((category) {
        return category.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    print("Filtered categories: ${_filteredCategories.length}"); // Log the number of filtered categories
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
