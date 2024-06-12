import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import '../../ViewModels/Category/ViewCategoryViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'ProductDetailsView.dart'; // Import the localization

class CategoryProductView extends StatelessWidget {
  final String categoryName;

  CategoryProductView({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Retrieve localized strings

    return ChangeNotifierProvider(
      create: (context) => ViewCategoryViewModel()..fetchProductsByCategory(categoryName),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColor.primary),
          title: Text(
            '${localizations.product}', // Use localized string
            style: TextStyle(
              color: AppColor.primary,
              fontSize: AppText.HeadingOne.fontSize,
              fontWeight: AppText.HeadingOne.fontWeight,
            ),
          ),
          centerTitle:true ,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/addProduct');
              },
            ),
          ],
        ),
        body: Consumer<ViewCategoryViewModel>(
          builder: (context, model, _) {
            if (model.errorMessage != null) {
              return Center(child: Text(model.errorMessage!));
            }
            if (model.products.isEmpty) {
              return Center(child: Text(localizations.noProductsFound)); // Use localized string
            }
            return ListView.builder(
              itemCount: model.products.length,
              itemBuilder: (context, index) {
                var product = model.products[index];
                return ListTile(
                  leading: _buildImage(product['imagePath']),
                  title: Text(product['productName']),
                  subtitle: Text('${localizations.quantity}: ${product['quantity']}'), // Use localized string
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    final productId = product['productId'];
                    print('Navigating to Product with ID: $productId');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(productId: productId),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return _placeholderImage();
    }

    return ClipOval(
      child: Image(
        image: NetworkImage(imagePath),
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _placeholderImage();
        },
      ),
    );
  }

  Widget _placeholderImage() {
    return ClipOval(
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Icon(Icons.image, color: Colors.white),
      ),
    );
  }
}