import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarcodeViewModel extends ChangeNotifier {
  List<Widget> _generatedBarcodes = [];

  List<Widget> get generatedBarcodes => _generatedBarcodes;

  int _barcodeCount = 0;

  int get barcodeCount => _barcodeCount;

  set barcodeCount(int value) {
    _barcodeCount = value;
    notifyListeners();
  }

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