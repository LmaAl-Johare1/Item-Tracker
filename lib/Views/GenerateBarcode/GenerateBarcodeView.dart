import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModels/GenerateBarcode/GenerateBarcodeViewModel.dart';

import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import 'BarcodeDisplayView.dart';

class GenerateBarcodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BarcodeViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColor.primary),
          title: Text(
            'Generate Barcode',
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
        body: Consumer<BarcodeViewModel>(
          builder: (context, viewModel, child) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      'assets/img/barcode.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Choose how many barcodes you want to generate',
                        style: TextStyle(fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              if (viewModel.barcodeCount > 0) {
                                viewModel.barcodeCount--;
                              }
                            },
                          ),
                          SizedBox(width: 16),
                          Text(
                            '${viewModel.barcodeCount}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 16),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              viewModel.barcodeCount++;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColor.primary,
                      minimumSize: Size(204, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                    ),
                    onPressed: () {
                      if (viewModel.barcodeCount > 0) {
                        viewModel.generateBarcodes();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BarcodeDisplayView(viewModel.generatedBarcodes)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('No barcode selected.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Text('Generate', style: AppText.ButtunText),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
