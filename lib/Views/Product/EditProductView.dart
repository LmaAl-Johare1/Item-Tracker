import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../ViewModels/Products/EditProductViewModel.dart';

class EditProductView extends StatefulWidget {
  final String productId;

  EditProductView({required this.productId});

  @override
  _EditProductViewState createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return ChangeNotifierProvider(
      create: (_) => EditProductViewModel(widget.productId),
      child: Consumer<EditProductViewModel>(
        builder: (context, model, _) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColor.primary),
            title: Text(
              localizations.edit,
              style: TextStyle(
                color: AppColor.primary,
                fontSize: AppText.HeadingOne.fontSize,
                fontWeight: AppText.HeadingOne.fontWeight,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
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
                                leading: Icon(Icons.photo_library),
                                title: Text(localizations.chooseFromGallery),
                                onTap: () async {
                                  Navigator.pop(context);
                                  final pickedImage = await picker.getImage(source: ImageSource.gallery);
                                  if (pickedImage != null) {
                                    model.updateImagePath(pickedImage.path);
                                  }
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.photo_camera),
                                title: Text(localizations.takeAPhoto),
                                onTap: () async {
                                  Navigator.pop(context);
                                  final pickedImage = await picker.getImage(source: ImageSource.camera);
                                  if (pickedImage != null) {
                                    model.updateImagePath(pickedImage.path);
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
                    child: model.imagePath != null && model.imagePath!.isNotEmpty
                        ? Image.file(File(model.imagePath!))
                        : Icon(Icons.camera_alt, size: 50, color: Colors.grey[700]),
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 40),

                TextField(
                  controller: model.productNameController,
                  onChanged: model.updateProductName,
                  decoration: _inputDecoration(localizations.productName),
                ),
                SizedBox(height: 40),

                TextField(
                  controller: model.productIdController,
                  onChanged: model.updateProductId,
                  decoration: _inputDecoration(localizations.productId).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.qr_code_scanner, color: AppColor.primary),
                      onPressed: () async {
                        // await model.scanBarCode();
                      },
                    ),
                  ),
                ),

                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.remove, color: AppColor.primary),
                              onPressed: model.decrementQuantity),
                          SizedBox(
                            width: 60,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: TextEditingController(text: model.quantity.toString())
                                ..selection = TextSelection.collapsed(offset: model.quantity.toString().length),
                              onChanged: (value) {
                                int? newQuantity = int.tryParse(value);
                                if (newQuantity != null) {
                                  model.quantity = newQuantity;
                                }
                              },
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.add, color: AppColor.primary),
                              onPressed: model.incrementQuantity),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: TextField(
                        controller: model.expDateController,
                        decoration: _inputDecoration(localizations.expDate),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: model.expDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) model.updateExpDate(pickedDate);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),

                DropdownButtonFormField<String>(
                  value: model.selectedCategory,
                  items: model.categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    model.updateSelectedCategory(value);
                  },
                  decoration: InputDecoration(labelText: localizations.category),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColor.primary,
                      minimumSize: Size(204, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                    ),
                    onPressed: model.saveProduct,
                    child: Text(localizations.save, style: AppText.ButtunText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
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
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }
}
