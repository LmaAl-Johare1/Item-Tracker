import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import the localization
import '../../ViewModels/ProductViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import 'EditProductView.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  ProductDetailsScreen({required this.productId}) {
    print('ProductDetailsScreen initialized with productId: $productId');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel()..fetchProduct(productId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColor.primary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(AppLocalizations.of(context)!.productDetails, // Use localized string
              style: TextStyle(
                  fontSize: AppText.HeadingOne.fontSize,
                  fontWeight: AppText.HeadingOne.fontWeight,
                  color: AppColor.primary)),
          centerTitle: true,
          elevation: 0, // Removes shadow under the app bar
        ),
        body: Consumer<ProductViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.product == null) {
              return Center(child: CircularProgressIndicator());
            }
            final product = viewModel.product!;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
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
                          title: Text(
                            product.productName,
                            style: TextStyle(
                              fontSize: AppText.HeadingTwo.fontSize,
                              fontWeight: AppText.HeadingTwo.fontWeight,
                              color: AppColor.primary,
                            ),
                          ),
                          subtitle: Text(
                            '${AppLocalizations.of(context)!.id}: ${product.productId}', // Use localized string
                            style: TextStyle(
                              fontSize: AppText.HeadingFive.fontSize,
                              fontWeight: AppText.HeadingFive.fontWeight,
                              color: AppColor.productInfo,
                            ),
                          ),
                          trailing: TextButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditProductPage(product: product),
                                ),
                              );
                              if (result == true) {
                                // Refresh product details after edit
                                viewModel.fetchProduct(productId);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.edit, // Use localized string
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 25),
                    decoration: BoxDecoration(
                      color: AppColor.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.items, // Use localized string
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 25),
                    decoration: BoxDecoration(
                      color: AppColor.validation, // Light red background
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.expDate, // Use localized string
                          style: TextStyle(
                            fontSize: AppText.HeadingThree.fontSize,
                            fontWeight: AppText.HeadingThree.fontWeight,
                            color: AppColor.secondary,
                          ),
                        ),
                        Text(
                          '${product.expDate.toLocal()}'.split(' ')[0],
                          style: TextStyle(
                            fontSize: AppText.HeadingFour.fontSize,
                            fontWeight: AppText.HeadingFour.fontWeight,
                            color: AppColor.secondary,
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
