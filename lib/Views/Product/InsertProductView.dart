import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import 'package:project/ViewModels/Products/InsertProductViewModel.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/// View for inserting a new product.
class InsertProductView extends StatelessWidget {
  const InsertProductView({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => InsertProductViewModel(),
      child: _InsertProductView(),
    );
  }
}

class _InsertProductView extends StatefulWidget {
  @override
  _InsertProductViewState createState() => _InsertProductViewState();
}

class _InsertProductViewState extends State<_InsertProductView> {
  late InsertProductViewModel _viewModel;
  String? _selectedCategory;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<InsertProductViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          localizations.insertProduct,
          style: TextStyle(
            color: AppColor.primary,
            fontSize: AppText.HeadingOne.fontSize,
            fontWeight: AppText.HeadingOne.fontWeight,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.primary),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () async {
                final picker = ImagePicker();
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: Text(localizations.chooseFromGallery),
                            onTap: () async {
                              Navigator.pop(context);
                              final pickedImage = await picker.getImage(source: ImageSource.gallery);
                              if (pickedImage != null) {
                                _viewModel.updateImagePath(pickedImage.path);
                              }
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_camera),
                            title: Text(localizations.takeAPhoto),
                            onTap: () async {
                              Navigator.pop(context);
                              final pickedImage = await picker.getImage(source: ImageSource.camera);
                              if (pickedImage != null) {
                                _viewModel.updateImagePath(pickedImage.path);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: _viewModel.imagePath != null
                    ? Image.file(File(_viewModel.imagePath!))
                    : Icon(Icons.camera_alt, size: 50, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: _viewModel.updateProductName,
                decoration: _inputDecoration(localizations.productName, _viewModel.productNameError),
              ),
            ),
            SizedBox(height: _viewModel.productNameError != null ? 20: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: _viewModel.updateProductId,
                controller: TextEditingController(text: _viewModel.productId ?? ''),
                decoration: _inputDecoration(localizations.productId,_viewModel.productIdError).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.qr_code_scanner, color: AppColor.primary),
                    onPressed: () async {
                      await _viewModel.scanBarCode();
                    },
                  ),
                ),
              ),
            ),

            SizedBox(height: _viewModel.productIdError != null ? 20 : 40),
            // Adjusted spacing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: AppColor.primary),
                          onPressed: _viewModel.decrementQuantity,
                        ),
                        SizedBox(
                          width: 60,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            controller: TextEditingController(
                                text: _viewModel.quantity.toString()
                            )..selection = TextSelection.collapsed(
                                offset: _viewModel.quantity.toString().length
                            ),
                            onChanged: (value) {
                              int? newQuantity = int.tryParse(value);
                              if (newQuantity != null) {
                                _viewModel.quantity = newQuantity;
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: AppColor.primary),
                          onPressed: _viewModel.incrementQuantity,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    flex: 2,
                    child: TextField(
                      controller: TextEditingController(
                          text: _viewModel.expDate?.toString().split(' ')[0]
                      ),
                      decoration: _inputDecoration(localizations.expDate, _viewModel.expDateError),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) _viewModel.updateExpDate(pickedDate);
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (_viewModel.quantityError != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  _viewModel.quantityError!,
                  style: TextStyle(color: Colors.red,fontSize :12 ),
                ),
              ),
            SizedBox(height: _viewModel.expDateError != null ? 20 : 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                dropdownColor: Colors.white,
                items: _viewModel.categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                    _viewModel.updateSelectedCategory(value);
                  });
                },
                decoration: _inputDecoration(localizations.category, _viewModel.categoryError),
              ),
            ),
            SizedBox(height: _viewModel.categoryError != null ? 20 : 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColor.primary,
                  minimumSize: Size(204, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                onPressed: () async {
                  bool success = await _viewModel.saveProduct();
                  String message = success ? 'Product inserted successfully' : 'Failed to insert product';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(localizations.save, style: AppText.ButtunText),
              ),
            ),

          ],
        ),
      ),
    );
  }

  /// Customizes input decoration for text fields.
  InputDecoration _inputDecoration(String label, String? errorText) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColor.FieldLabel, fontWeight: FontWeight.bold),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: AppColor.primary, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: AppColor.primary, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 12),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      errorText: errorText,
      errorStyle: TextStyle(color: Colors.red, fontSize :12 ),
    );
  }
}