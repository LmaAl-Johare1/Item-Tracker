import 'package:flutter/material.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

// Model
class UserModel {
  String businessName;
  String businessAddress;
  String phoneNumber;
  String email;

  UserModel({
    required this.businessName,
    required this.businessAddress,
    required this.phoneNumber,
    required this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      businessName: data['businessName'] ?? '',
      businessAddress: data['businessAddress'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      email: data['email'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'businessName': businessName,
      'businessAddress': businessAddress,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }
}
