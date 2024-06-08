import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Services/network_service.dart';
import 'package:project/Models/Category.dart';

class ViewCategoryViewModel with ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  List<Category> _categories = [];
  String? _errorMessage;

  List<Category> get categories => _categories;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCategories() async {
    try {
      final List<Map<String, dynamic>> data = await _networkService.fetchAll('Categories');
      _categories = data.map((json) => Category.fromJson(json)).toList();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load categories. Please try again later.";
      print('Error fetching categories: $e'); // Detailed logging
    }
    notifyListeners();
  }

  Future<void> fetchProductsByCategory(String categoryName) async {
    try {
      List<DocumentSnapshot> result = await _networkService.fetchProductsByCategory(categoryName);
      _products = result.map((doc) => doc.data() as Map<String, dynamic>).toList();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load products. Please try again later.";
      print('Error fetching products by category: $e'); // Detailed logging
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> get products => _products;
}
