import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';

import '../../ViewModels/ProfileViewModel.dart';

class Profile extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: AppText.headingOne.fontSize,
                          fontWeight: AppText.headingThree.fontWeight,
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0,
                    child: Icon(
                      Icons.navigate_before,
                      color: AppColor.primary,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Personal Information',
                    style: TextStyle(
                      color: AppColor.secondary,
                      fontSize: AppText.headingTwo.fontSize,
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    children: <Widget>[
                      SizedBox(height: 50),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                color: AppColor.primary,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/EditProfile');
                                },
                              ),
                              const Text(
                                'Edit',
                                style: TextStyle(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            controller: viewModel.businessNameController,
                            decoration: _buildInputDecoration('Business Name', "ItemTracker"),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Column(
                        children: [
                          TextField(
                            controller: viewModel.businessAddressController,
                            decoration: _buildInputDecoration('Business Address', "Palestine, Nablus"),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Column(
                        children: [
                          TextField(
                            controller: viewModel.phoneController,
                            decoration: _buildInputDecoration('Phone Number', "+970599900022"),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      TextField(
                        controller: viewModel.emailController,
                        decoration: _buildInputDecoration('Email', "Test@gmail.com"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
