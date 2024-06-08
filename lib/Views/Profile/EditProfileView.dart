import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';

import '../../ViewModels/Profile/EditProfileViewModel.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: AppText.headingOne.fontSize,
              fontWeight: AppText.headingThree.fontWeight,
              color: AppColor.primary,
            ),
          ),
          centerTitle: true,
        ),
        body: Consumer<EditProfileViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(
                      color: AppColor.secondary,
                      fontSize: AppText.headingTwo.fontSize,
                    ),
                  ),
                  SizedBox(height: 30),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    children: <Widget>[
                      SizedBox(height: 40),
                      Column(
                        children: [
                          TextField(
                            controller: viewModel.businessNameController,
                            decoration: _buildInputDecoration('Business Name', "ItemTracker"),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Column(
                        children: [
                          TextField(
                            controller: viewModel.businessAddressController,
                            decoration: _buildInputDecoration('Business Address', "Palestine, Nablus"),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Column(
                        children: [
                          TextField(
                            controller: viewModel.phoneController,
                            decoration: _buildInputDecoration('Phone Number', "+970599900022"),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      TextField(
                        controller: viewModel.emailController,
                        decoration: _buildInputDecoration('Email', "Test@gmail.com"),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              viewModel.saveChanges(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text('Save', style: AppText.ButtonText),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the current screen without saving changes
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text('Cancel', style: AppText.ButtonText),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String labelText, String placeholder) {
    return InputDecoration(
      labelText: labelText,
      hintText: placeholder,
      labelStyle: TextStyle(
        color: AppColor.primary,
        fontWeight: FontWeight.bold,
      ),
      hintStyle: TextStyle(
        color: AppColor.secondary.withOpacity(0.9),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: AppColor.primary.withOpacity(0.99),
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: AppColor.primary.withOpacity(0.99),
          width: 2,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }
}
