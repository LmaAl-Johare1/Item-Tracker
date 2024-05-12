import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import '../../viewmodels/ViewCategoryViewModel.dart';

class ViewCategoryScreen extends StatefulWidget {
  @override
  _ViewCategoryScreenState createState() => _ViewCategoryScreenState();
}

class _ViewCategoryScreenState extends State<ViewCategoryScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryViewModel()..fetchCategories(),
      child: Scaffold(
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
              Navigator.pop(context);
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

        body: Column(

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search for categories",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none, // No visible border
                  ),
                ),
                onChanged: (value) {
                  Provider.of<CategoryViewModel>(context, listen: false).filterCategories(value);
                },
              ),
            ),

            SizedBox(height: 40),

            Expanded(
              child: Consumer<CategoryViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.errorMessage != null) {
                    return Center(
                      child: Text(viewModel.errorMessage!),
                    );
                  }
                  if (viewModel.categories.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: viewModel.filteredCategories.length,
                    itemBuilder: (context, index) {
                      var category = viewModel.filteredCategories[index];
                      return Card(
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              category.imageUrl,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            category.name,
                            style: TextStyle(
                              fontWeight: AppText.headingFour.fontWeight,
                              fontSize: AppText.headingFour.fontSize,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to category-specific products page
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),




      ),
    );
  }
}
