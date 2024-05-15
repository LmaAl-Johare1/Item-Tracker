import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/Category.dart';
import '../Services/network_service.dart';

class ViewCategoryViewModel with ChangeNotifier {

  final NetworkService _networkService = NetworkService();
  List<Map<String, dynamic>> _products = [];

  List<Map<String, dynamic>> get products => _products;

  Future<void> fetchProductsByCategory(String categoryName) async {
    try {
      List<DocumentSnapshot> result = await _networkService
          .fetchProductsByCategory(categoryName);
      _products =
          result.map((doc) => doc.data() as Map<String, dynamic>).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  List<Category> _categories = [];
  List<Category> _filteredCategories = []; // Holds filtered categories
  String? _errorMessage;

  List<Category> get categories => _categories;

  List<Category> get filteredCategories =>
      _filteredCategories.isEmpty ? _categories : _filteredCategories;

  String? get errorMessage => _errorMessage;


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