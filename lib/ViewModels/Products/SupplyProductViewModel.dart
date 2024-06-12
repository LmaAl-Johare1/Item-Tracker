import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../Models/products.dart';
import '../../Services/network_service.dart';
import '../Dashboard/DashboardViewModel.dart';

/// ViewModel for managing the supply of products.
///
/// This class provides functionality to scan product barcodes,
/// fetch product information, update product supply quantity,
/// and send reports.
class SupplyProductViewModel with ChangeNotifier {
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController supplyQuantityController = TextEditingController();
  String scannedProductId = '';
  String productInfoMessage = '';
  Product? product;
  int suppliedQuantity = 0;
  final NetworkService _networkService = NetworkService();
  final MyHomePageViewModel _dashboardViewModel;

  /// Constructs the [SupplyProductViewModel] with the given [MyHomePageViewModel].
  ///
  /// [dashboardViewModel] The view model for the dashboard.
  SupplyProductViewModel(this._dashboardViewModel);

  /// Scans a product barcode and fetches product information.
  ///
  /// This method uses the FlutterBarcodeScanner to scan the barcode.
  /// If the scan is successful, it fetches the product information
  /// based on the scanned product ID.
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

  /// Updates the product ID and fetches product information.
  ///
  /// [value] The new product ID.
  void updateProductId(String value) async {
    scannedProductId = value;
    await fetchProductInfo(value);
    notifyListeners();
  }

  /// Updates the supply quantity.
  ///
  /// [value] The new supply quantity.
  void updateSupplyQuantity(String value) {
    supplyQuantityController.text = value;
    notifyListeners();
  }

  /// Fetches product information based on the product ID.
  ///
  /// This method retrieves the product data from Firestore
  /// and updates the local product state.
  ///
  /// [productId] The ID of the product to fetch.
  Future<void> fetchProductInfo(String productId) async {
    try {
      var data = await _networkService.fetchData('products', 'productId', productId);
      if (data.isNotEmpty) {
        product = Product.fromMap(data, productId);
        productInfoMessage =
        'The inventory has ${product!.quantity} of ${product!.productName}. Please enter the quantity you want to supply.';
      } else {
        productInfoMessage = 'Product not found in the inventory.';
      }
    } catch (error) {
      productInfoMessage = 'Error fetching Product information';
    }
    notifyListeners();
  }

  /// Saves the supplied product quantity to the database and sends a report.
  ///
  /// This method updates the product quantity in Firestore,
  /// sends a report of the supply operation, and updates the dashboard.
  Future<void> saveProduct() async {
    if (product != null) {
      suppliedQuantity = int.tryParse(supplyQuantityController.text) ?? 0;
      DateTime now = DateTime.now();

      try {
        if (suppliedQuantity > product!.quantity) {
          throw Exception('Supplied quantity cannot exceed available quantity');
        }

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

        // Update dashboard
        _dashboardViewModel.updateProductOut(suppliedQuantity);

        // Prepare and send the report
        final reportData = {
          'operation': 'Supply Product',
          'date': DateTime.now(),
          'description': 'Supplied product ${product!.productName} with quantity $suppliedQuantity',
        };
        await _networkService.sendData('Reports', reportData);

        // Clear the controllers and reset state
        supplyQuantityController.clear();
        productIdController.clear();
        scannedProductId = '';
        productInfoMessage = 'Product supplied successfully';
      } catch (error) {
        productInfoMessage = 'Error: $error';
      }
    } else {
      productInfoMessage = 'No Product information available to update quantity.';
    }
    notifyListeners();
  }
}
