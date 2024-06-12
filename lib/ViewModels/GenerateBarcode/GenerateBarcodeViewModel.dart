import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

/// ViewModel for generating barcode widgets.
class BarcodeViewModel extends ChangeNotifier {
  List<Widget> _generatedBarcodes = [];

  /// Getter for the list of generated barcode widgets.
  List<Widget> get generatedBarcodes => _generatedBarcodes;

  int _barcodeCount = 0;

  /// Getter for the number of barcodes to be generated.
  int get barcodeCount => _barcodeCount;

  /// Setter for the number of barcodes to be generated.
  ///
  /// [value] - The number of barcodes.
  set barcodeCount(int value) {
    _barcodeCount = value;
    notifyListeners();
  }

  /// Generates barcode widgets based on the specified barcode count.
  ///
  /// Clears the existing list of generated barcodes and adds new barcode widgets.
  void generateBarcodes() {
    _generatedBarcodes.clear();
    for (int i = 0; i < _barcodeCount; i++) {
      final barcodeWidget = BarcodeWidget(
        barcode: Barcode.code128(),
        data: '0123456789${i.toString().padLeft(5, '0')}',
        width: 200,
        height: 100,
        style: TextStyle(fontSize: 20),
      );
      _generatedBarcodes.add(barcodeWidget);
    }
    notifyListeners();
  }
}
