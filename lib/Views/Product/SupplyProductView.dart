import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../ViewModels/Dashboard/DashboardViewModel.dart';
import '../../ViewModels/products/SupplyProductViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';

class SupplyProductPage extends StatefulWidget {
  @override
  _SupplyProductPageState createState() => _SupplyProductPageState();
}

class _SupplyProductPageState extends State<SupplyProductPage> {
  late SupplyProductViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SupplyProductViewModel(MyHomePageViewModel());
    _viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _viewModel.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.primary),
        title: Text(
          localizations.supplyProduct,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              TextField(
                controller: _viewModel.productIdController,
                onChanged: _viewModel.updateProductId,
                decoration: _inputDecoration(localizations.productId).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.qr_code_scanner, color: AppColor.primary),
                    onPressed: () async {
                      await _viewModel.scanProduct();
                    },
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                _viewModel.productInfoMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: AppColor.FieldLabel,
                ),
              ),
              SizedBox(height: 50),
              TextField(
                controller: _viewModel.supplyQuantityController,
                onChanged: _viewModel.updateSupplyQuantity,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(localizations.quantity).copyWith(
                  labelStyle: TextStyle(
                    color: AppColor.FieldLabel,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColor.primary,
                    minimumSize: Size(204, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                  ),
                  onPressed: _viewModel.saveProduct,
                  child: Text(
                    localizations.save,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: AppColor.FieldLabel,
        fontWeight: FontWeight.bold,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: AppColor.primary,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: AppColor.primary,
          width: 2,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }
}