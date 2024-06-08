import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../ViewModels/Setting/DeleteAccountViewModel.dart';

class DeleteAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.primary),
        title: Text(
          localizations.deleteAccount,
          style: TextStyle(
            color: AppColor.primary,
            fontSize: AppText.headingOne.fontSize,
            fontWeight: AppText.headingOne.fontWeight,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/Setting');
          },
        ),
      ),
      body: ChangeNotifierProvider<DeleteAccountViewModel>(
        create: (_) => DeleteAccountViewModel()..fetchEmails(),
        child: Consumer<DeleteAccountViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    if (viewModel.emails.isEmpty) ...[
                      CircularProgressIndicator(),
                    ] else ...[
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: viewModel.selectedAccount.isNotEmpty ? viewModel.selectedAccount : null,
                          hint: Text(localizations.chooseAccount),
                          items: viewModel.emails.map((String email) {
                            return DropdownMenuItem<String>(
                              value: email,
                              child: Text(email),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            viewModel.setSelectedAccount(newValue!);
                          },
                        ),
                      ),
                    ],
                    SizedBox(height: 250),
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          String password = await _showPasswordDialog(context);
                          if (password.isNotEmpty) {
                            await viewModel.deleteAccount(password);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(localizations.deleteAccount),
                                  content: Text(viewModel.message),
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
                        child: Text(
                          localizations.delete,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppText.ButtonText.fontSize,
                            fontWeight: AppText.ButtonText.fontWeight,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 64, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      viewModel.message,
                      style: TextStyle(
                        color: AppColor.validation,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<String> _showPasswordDialog(BuildContext context) async {
    TextEditingController _passwordController = TextEditingController();
    return await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Enter Password'),
          content: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop('');
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(_passwordController.text);
              },
            ),
          ],
        );
      },
    ) ?? '';
  }
}
