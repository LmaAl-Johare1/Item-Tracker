import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import your generated localization

import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import 'package:project/ViewModels/Category/InsertCategoryViewModel.dart';

class InsertCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColor.primary),
          title: Text(
            AppLocalizations.of(context)!.insertCategory, // Localized title
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
              Navigator.pushReplacementNamed(context, '/CategoryfromInsert');
            },
          ),
        ),
        body: Consumer<CategoryViewModel>(
          builder: (context, model, _) => SingleChildScrollView(
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
                                title: Text(AppLocalizations.of(context)!.chooseFromGallery), // Localized text
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
                                title: Text(AppLocalizations.of(context)!.takeAPhoto), // Localized text
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
                    child: model.imagePath != null
                        ? Image.file(File(model.imagePath!))
                        : Icon(Icons.camera_alt, size: 50, color: Colors.grey[700]),
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  onChanged: model.updateCategoryName,
                  decoration: _inputDecoration(AppLocalizations.of(context)!.categoryName), // Localized text
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColor.primary,
                      minimumSize: Size(204, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                    ),
                    onPressed: model.saveCategory,
                    child: Text(AppLocalizations.of(context)!.save, style: AppText.ButtunText), // Localized text
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
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: AppColor.primary, width: 2)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: AppColor.primary, width: 2)),
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }
}