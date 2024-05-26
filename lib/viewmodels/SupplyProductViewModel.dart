import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../Models/products.dart';
import '../Services/network_service.dart';
import 'DashboardViewModel.dart';

/// ViewModel for managing the supply of products.
class SupplyProductViewModel with ChangeNotifier {
  TextEditingController productIdController = TextEditingController();
  TextEditingController supplyQuantityController = TextEditingController();
  String scannedProductId = '';
  String productInfoMessage = '';
  Product? product;
  int suppliedQuantity = 0;
  final NetworkService _networkService = NetworkService();
  final MyHomePageViewModel _dashboardViewModel;
  SupplyProductViewModel(this._dashboardViewModel);

  /// Scans a product barcode and fetches product information.
  Future<void> scanProduct() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    if (barcodeScanRes != '-1') {
      scannedProductId = barcodeScanRes;
      productIdController.text = barcodeScanRes;
      await fetchProductInfo(barcodeScanRes);
      notifyListeners();
    }
  }

  void updateProductId(String value) {
    scannedProductId = value;
    notifyListeners();
  }

  void updateSupplyQuantity(String value) {
    supplyQuantityController.text = value;
    notifyListeners();
  }

  /// Fetches product information based on the product ID.
  Future<void> fetchProductInfo(String productId) async {
    try {
      var data = await _networkService.fetchData(
          'products', 'productId', productId);
      if (data.isNotEmpty) {
        product = Product.fromMap(data, productId);
        productInfoMessage =
        'The inventory has ${product!.quantity} of ${product!.productName}. Please enter the quantity you want to supply.';
      } else {
        productInfoMessage = 'Product not found in the inventory.';
      }
    } catch (error) {
      productInfoMessage = 'Error fetching product information';
    }
    notifyListeners();
  }

  /// Saves the supplied product quantity to the database.
  Future<void> saveProduct() async {
    if (product != null) {
      suppliedQuantity = int.tryParse(supplyQuantityController.text) ?? 0;
      DateTime now = DateTime.now();

      try {
        if (suppliedQuantity > product!.quantity) {
          throw Exception('Supplied quantity cannot exceed available quantity');
        }

        final reportData = {
          'operation': 'Insert Product',
          'date': DateTime.now(),
          'description': 'Inserted product ${product?.productName} with quantity ${product?.quantity}',
        };
        await _networkService.sendData('Reports', reportData);



        int newStock = product!.quantity - suppliedQuantity;

        await _networkService.updateData(
          'products',
          'productId',
          product!.productId!,
          {
            'quantity': newStock,
            'supply_date': now,
            'supplied_quantity': suppliedQuantity,
          },
        );


        _dashboardViewModel.updateProductOut(suppliedQuantity);

        supplyQuantityController.clear();
        productIdController.clear();
        scannedProductId = '';

        productInfoMessage = 'Product supplied successfully';
      } catch (error) {
        productInfoMessage = 'Error: $error';
      }
    } else {
      productInfoMessage = 'No product information available to update quantity.';
    }
    notifyListeners();
  }
}
