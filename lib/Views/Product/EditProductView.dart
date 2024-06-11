import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Models/products.dart';
import '../../ViewModels/Products/EditProductViewModel.dart';

class EditProductView extends StatefulWidget {
  final Product product;

  EditProductView({required this.product});

  @override
  _EditProductViewState createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProductViewModel(widget.product),
      child: Consumer<EditProductViewModel>(
        builder: (context, model, _) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColor.primary),
            title: Text(
              AppLocalizations.of(context)!.edit,
              style: TextStyle(
                color: AppColor.primary,
                fontSize: AppText.HeadingOne.fontSize,
                fontWeight: AppText.HeadingOne.fontWeight,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
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
                                  title: Text(AppLocalizations.of(context)!.chooseFromGallery),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    await model.pickImage(ImageSource.gallery);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.photo_camera),
                                  title: Text(AppLocalizations.of(context)!.takeAPhoto),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    await model.pickImage(ImageSource.camera);
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
                      child: model.imagePath != null && model.imagePath!.isNotEmpty
                          ? (model.imagePath!.startsWith('http')
                          ? Image.network(model.imagePath!)
                          : Image.file(File(model.imagePath!)))
                          : Image.asset('assets/img/defualt.png'), // Provide default image
                    ),
                  ),
                  SizedBox(height: 40),

                  TextFormField(
                    controller: model.productNameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.productName,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.error;
                      }
                      return null;
                    },
                    onChanged: model.updateProductName,
                  ),
                  SizedBox(height: 20),

                  TextFormField(
                    controller: model.quantityController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.quantity,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.error;
                      }
                      return null;
                    },
                    onChanged: model.updateQuantity,
                  ),
                  SizedBox(height: 20),

                  Row(
                    children: [
                      Text(
                        model.expDate == null
                            ? AppLocalizations.of(context)!.noDateChosen
                            : '${AppLocalizations.of(context)!.expDate}: ${model.expDate!.toLocal()}'.split(' ')[0],
                      ),
                      SizedBox(width: 20.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: model.expDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            model.updateExpDate(pickedDate);
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.chooseDate),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColor.primary,
                        minimumSize: Size(204, 55),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          model.saveProduct(context);
                          Navigator.pop(context, true); // Return true to indicate success
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.save, style: AppText.ButtunText), // Localized text
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
