import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Services/network_service.dart';
import '../../ViewModels/Setting/ChangeEmailViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';

class ChangeEmailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangeEmailViewModel(networkService: NetworkService()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColor.primary),
          title: Text(
            'Change Email Address',
            style: TextStyle(
              color: AppColor.primary,
              fontSize: AppText.headingThree.fontSize,
              fontWeight: AppText.headingOne.fontWeight,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/SettingsPage');
            },
          ),
        ),
        body: Consumer<ChangeEmailViewModel>(
          builder: (context, model, child) {
            print('Current emails: ${model.emails}');
            print('Selected email: ${model.selectedEmail}');

            if (model.emails.isNotEmpty && model.selectedEmail != null && !model.emails.contains(model.selectedEmail)) {
              model.selectedEmail = null;
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      if (model.emails.isNotEmpty)
                        SizedBox(
                          width: double.infinity,
                          height: 56, // Adjust height to match the TextField height
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text('Choose email'),
                              value: model.selectedEmail,
                              onChanged: (String? newValue) {
                                model.selectedEmail = newValue;
                                model.notifyListeners();
                              },
                              items: model.emails.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              isExpanded: true, // Ensure dropdown is full width
                            ),
                          ),
                        ),
                      if (model.emails.isEmpty)
                        CircularProgressIndicator(),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      TextField(
                        controller: model.newEmailController,
                        decoration: InputDecoration(
                          labelText: "New Email Address",
                          labelStyle: const TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: AppColor.primary.withOpacity(0.99),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: AppColor.primary.withOpacity(0.99),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColor.primary,
                            minimumSize: Size(204, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          onPressed: () async {
                            await model.changeEmail();
                            if (model.successMessage.isNotEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text('Success'),
                                    content: Text(model.successMessage),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.pushReplacementNamed(context, '/SettingsPage');
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (model.errorMessage.isNotEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text('Error'),
                                    content: Text(model.errorMessage),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text('Save', style: AppText.ButtonText),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
