import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import '../../ViewModels/ViewCategoryViewModel.dart';
import '../Product/ProductDetailsView.dart';

class CategoryProductView extends StatelessWidget {
  final String categoryName;

  CategoryProductView({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ViewCategoryViewModel()..fetchProductsByCategory(categoryName),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColor.primary),
          title: Text(
            'Products in $categoryName',
            style: TextStyle(
              color: AppColor.primary,
              fontSize: AppText.HeadingOne.fontSize,
              fontWeight: AppText.HeadingOne.fontWeight,
            ),
          ),
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
            if (model.products.isEmpty) {
              return Center(child: Text('No products found for this category.'));
            }
            return ListView.builder(
              itemCount: model.products.length,
              itemBuilder: (context, index) {
                var product = model.products[index];
                return ListTile(
                  title: Text(product['productName']),
                  subtitle: Text('Quantity: ${product['quantity']}'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    final productId = product['productId'];
                    print('Navigating to product with ID: $productId');
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
}
