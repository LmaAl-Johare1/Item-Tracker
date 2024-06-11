import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModels/Category/ViewCategoryViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Product/CategoryProductView.dart'; // Import AppLocalizations

class ViewCategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ViewCategoryViewModel()..fetchCategories(),
      child: Consumer<ViewCategoryViewModel>(
        builder: (context, model, _) {
          if (model.errorMessage != null) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Text(
                  model.errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 24), // Adjusted for visibility
                ),
              ),
            );
          }
          if (model.categories.isEmpty) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColor.primary),
              title: Text(
                AppLocalizations.of(context)!.categories, // Localized title
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: AppText.HeadingOne.fontSize,
                  fontWeight: AppText.HeadingOne.fontWeight,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/addCategory');
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: model.categories.length,
                itemBuilder: (context, index) {
                  var category = model.categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryProductView(categoryName: category.name),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 89,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: category.imagePath != null && category.imagePath!.isNotEmpty
                                    ? Image.network(
                                  category.imagePath!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/img/defualt.png',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                                    : Image.asset(
                                  'assets/img/defualt.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                category.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 22), // Add padding to the right
                              child: Icon(Icons.arrow_forward),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}