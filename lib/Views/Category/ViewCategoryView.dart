import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModels/InsertProductViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import '../product/CategoryProductView.dart';
import '../product/InsertProductView.dart';

class ViewCategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<InsertProductViewModel>(
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColor.primary),
            title: Text(
              'Categories',
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
                // Navigator.pushReplacementNamed(context, '/dahsboardFromCategory');
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Navigator.pushReplacementNamed(context, '/addCategory');
                },
              ),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: model.categories.length,
                    itemBuilder: (context, index) {
                      var category = model.categories[index];
                      var categoryImage = getCategoryImage(category);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryProductView(categoryName: category),
                              ),
                            );
                          },
                          child: Container(
                            width: 304,
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
                                    // child: Image.asset(
                                    //   categoryImage,
                                    //   width: 60,
                                    //   height: 60,
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: const EdgeInsets.only(right: 22), // Add padding to the right
                                  child: Icon(Icons.arrow_forward_ios),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getCategoryImage(String category) {
    switch (category.toLowerCase()) {
      default:
        return 'assets/images/default.png'; // Add a default image if needed
    }
  }
}
