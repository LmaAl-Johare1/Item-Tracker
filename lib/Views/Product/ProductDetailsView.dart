import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../ViewModels/products/ProductViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import 'EditProductView.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  ProductDetailsScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel()..fetchProduct(productId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColor.primary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            AppLocalizations.of(context)!.productDetails,
            style: TextStyle(
              fontSize: AppText.HeadingOne.fontSize,
              fontWeight: AppText.HeadingOne.fontWeight,
              color: AppColor.primary,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Consumer<ProductViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.product == null) {
              return Center(child: CircularProgressIndicator());
            }
            final product = viewModel.product!;
            final imagePath = product.imagePath ?? 'assets/img/defualt.png'; // Provide a default value

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),

                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.productName,
                                style: TextStyle(
                                  fontSize: AppText.HeadingTwo.fontSize,
                                  fontWeight: AppText.HeadingTwo.fontWeight,
                                  color: AppColor.primary,
                                ),
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.id}: ${product.productId}',
                                style: TextStyle(
                                  fontSize: AppText.HeadingFive.fontSize,
                                  fontWeight: AppText.HeadingFive.fontWeight,
                                  color: AppColor.productInfo,
                                ),
                              ),
                            ],
                          ),
                          leading: Container(
                            width: 50,
                            height: 50,
                            child: imagePath.startsWith('http')
                                ? Image.network(
                              imagePath,
                              fit: BoxFit.cover,
                            )
                                : (imagePath != 'assets/img/defualt.png'
                                ? Image.file(
                              File(imagePath),
                              fit: BoxFit.cover,
                            )
                                : Image.asset(
                              'assets/img/defualt.png',
                              fit: BoxFit.cover,
                            )),
                          ),
                          trailing: TextButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProductView(
                                    product: product,
                                  ),
                                ),
                              );
                              if (result == true) {
                                viewModel.fetchProduct(productId);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.edit,
                              style: TextStyle(
                                fontSize: AppText.HeadingFive.fontSize,
                                fontWeight: AppText.HeadingFive.fontWeight,
                                color: AppColor.productInfo,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                    decoration: BoxDecoration(
                      color: AppColor.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.items,
                          style: TextStyle(
                            fontSize: AppText.HeadingThree.fontSize,
                            fontWeight: AppText.HeadingThree.fontWeight,
                            color: AppColor.primary,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          '${product.quantity}',
                          style: TextStyle(
                            fontSize: AppText.HeadingThree.fontSize,
                            fontWeight: AppText.HeadingThree.fontWeight,
                            color: AppColor.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                    decoration: BoxDecoration(
                      color: AppColor.Exdate,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.expDate,
                          style: TextStyle(
                            fontSize: AppText.HeadingThree.fontSize,
                            fontWeight: AppText.HeadingThree.fontWeight,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${product.expDate.toDate().toLocal()}'.split(' ')[0],
                          style: TextStyle(
                            fontSize: AppText.HeadingFour.fontSize,
                            fontWeight: AppText.HeadingFour.fontWeight,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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
