import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModels/ProductViewModel.dart';
import 'package:project/Models/Product.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  EditProductPage({required this.product}); // Ensure the constructor has this named parameter

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();
  DateTime? _expDate;

  @override
  void initState() {
    super.initState();
    _productNameController.text = widget.product.productName;
    _quantityController.text = widget.product.quantity.toString();
    _expDate = widget.product.expDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic> updatedData = {
                      'productName': _productNameController.text,
                      'quantity': int.parse(_quantityController.text),
                      'expDate': Timestamp.fromDate(_expDate!),
                      'productId': widget.product.productId,
                    };
                    // Call the updateProduct method in your ViewModel
                    context.read<ProductViewModel>().updateProduct(widget.product.productId, updatedData);
                    Navigator.pop(context, true);  // Return true to indicate success
                  }
                },
                child: Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
