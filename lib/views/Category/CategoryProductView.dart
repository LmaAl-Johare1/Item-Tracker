import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Models/Category.dart';

class CategoryProductsPage extends StatelessWidget {
  final Category category;

  const CategoryProductsPage({Key? key, required this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Center(
        child: Text('Products for ${category.name}'),
      ),
    );
  }
}
