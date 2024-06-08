import 'package:flutter/material.dart';

import '../../res/AppColor.dart';
import '../../res/AppText.dart';

class BarcodeDisplayView extends StatelessWidget {
  final List<Widget> barcodes;

  BarcodeDisplayView(this.barcodes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            'Generated Barcodes',
            style: TextStyle(
              color: AppColor.primary,
              fontSize: AppText.HeadingOne.fontSize,
              fontWeight: AppText.HeadingOne.fontWeight,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: AppColor.primary),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: barcodes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Center(child: barcodes[index]),
            ),
          );
        },
      ),
    );
  }
}