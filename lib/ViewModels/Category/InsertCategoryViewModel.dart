import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

import '../../Services/network_service.dart';

/// ViewModel for managing category data and image uploads.
class CategoryViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();

  String? _imagePath;
  String? _name;
  String? _errorMessage;
  File? _imageFile;
  String? _imageUrl;

  String? get imagePath => _imagePath;
  String? get name => _name;
  String? get errorMessage => _errorMessage;
  File? get imageFile => _imageFile;
  String? get imageUrl => _imageUrl;

  /// Updates the image path.
  void updateImagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }

  /// Updates the category name.
  void updateCategoryName(String name) {
    _name = name;
    _errorMessage = null; // Reset the error message when updating the name
    notifyListeners();
  }

  /// Picks an image from the device's camera.
  Future<void> pickImage() async {
    var pickedImage = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);
      notifyListeners();
    }
  }

  /// Uploads the selected image to Firebase Storage.
  Future<void> uploadImage(BuildContext context) async {
    if (_imageFile == null) return;
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = path.basename(_imageFile!.path);
      Reference ref = storage.ref().child('category_images/$fileName');
      UploadTask uploadTask = ref.putFile(_imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask;
      _imageUrl = await taskSnapshot.ref.getDownloadURL();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Image uploaded successfully'),
      ));
      notifyListeners();
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(ex.toString()),
      ));
    }
  }

  /// Saves the category data and image URL to the database.
  Future<void> saveCategory(BuildContext context) async {
    if (_name == null || _name!.isEmpty) {
      _errorMessage = "Please enter a valid category name";
      notifyListeners();
      return;
    }

    await uploadImage(context);

    if (_imageUrl == null) {
      _errorMessage = "Failed to upload image. Please try again.";
      notifyListeners();
      return;
    }

    Map<String, dynamic> data = {
      'imagePath': _imageUrl,
      'name': _name,
    };

    try {
      await _networkService.sendData('Categories', data);
      print('Category saved successfully');
      resetFields();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Category inserted successfully')),
      );
    } catch (error) {
      print('Failed to insert Category: $error');
      _errorMessage = "Failed to save category. Please try again later.";
      notifyListeners();
    }
  }

  /// Resets all fields to their initial state.
  void resetFields() {
    _imagePath = null;
    _name = null;
    _imageFile = null;
    _imageUrl = null;
    notifyListeners();
  }
}