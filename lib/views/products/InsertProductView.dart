import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import 'package:project/viewmodels/InsertProductViewModel.dart';

class InsertProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColor.primary),
          title: Text('Insert Product', style: TextStyle(color: AppColor.primary, fontSize: AppText.headingOne.fontSize, fontWeight: AppText.headingOne.fontWeight)),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
        ),
        body: Consumer<ProductViewModel>(
          builder: (context, model, _) => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    // Trigger camera functionality to capture image
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.camera_alt, size: 50, color: Colors.grey[700]),
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 40),


                TextField(
                  onChanged: model.updateProductName,
                  decoration: _inputDecoration('Product Name'),
                ),
                SizedBox(height: 40),


                TextField(
                  onChanged: model.updateProductId,
                  decoration: _inputDecoration('Product ID').copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.qr_code_scanner, color: AppColor.primary),
                      onPressed: () {
                        // Implement barcode scan functionality
                      },
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Flexible(
                      flex: 3,
                      child: Row(
                        children: [
                          IconButton(icon: Icon(Icons.remove,
                              color: AppColor.primary),
                              onPressed: model.decrementQuantity,
                          ),
                          SizedBox(
                            width: 60,
                            child: TextField(
                            keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: TextEditingController(text: model.quantity.toString())
                                ..selection = TextSelection.collapsed(offset: model.quantity.toString().length),
                              onChanged: (value){
                              int ? newQuantity = int.tryParse(value);
                              if(newQuantity != null){
                                model.quantity = newQuantity ;
                              }
                              },
                              onSubmitted: (value){
                                 border: OutlineInputBorder();
                          },
                            ),
                          ),
                          IconButton(icon: Icon(Icons.add, color: AppColor.primary), onPressed: model.incrementQuantity),
                        ],
                      ),
                    ),



                    Flexible(
                      flex: 2,
                      child: TextField(
                        controller: TextEditingController(text: model.expDate?.toString().split(' ')[0]),
                        decoration: _inputDecoration('Exp Date'),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) model.setExpDate(pickedDate);
                        },
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: AppColor.primary,
                      minimumSize: Size(204, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                    ),
                    onPressed: model.saveProduct,
                    child: Text('Save', style: AppText.ButtonText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColor.FieldLabel, fontWeight: FontWeight.bold),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: AppColor.primary, width: 2)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: AppColor.primary, width: 2)),
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }
}
