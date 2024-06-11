import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import the localization
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import '../../Services/network_service.dart';
import '../../ViewModels/Authentication/RegisterViewModel.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterViewModel _registerViewModel = RegisterViewModel(NetworkService());
  String _selectedRole = 'Admin';
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _businessNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _businessAddressController = TextEditingController();
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve localized strings
    localizations = AppLocalizations.of(context)!;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _businessNameController.dispose();
    _phoneNumberController.dispose();
    _businessAddressController.dispose();
    super.dispose();
  }

  void _handleFormSubmission() {
    _registerViewModel.setEmail(_emailController.text);
    _registerViewModel.setPassword(_passwordController.text);
    _registerViewModel.setConfirmPassword(_confirmPasswordController.text);
    _registerViewModel.setBusinessName(_businessNameController.text);
    _registerViewModel.setPhoneNumber(_phoneNumberController.text);
    _registerViewModel.setBusinessAddress(_businessAddressController.text);
    _registerViewModel.setSelectedRole(_selectedRole);

    if (_registerViewModel.validateFields()) {
      _registerViewModel.signUp().then((_) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }).catchError((error) {
        _showSnackBar('Error signing up: $error');
      });
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _registerViewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColor.primary),
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/RegisterBack');
            },
          ),
          title: Text(
            localizations.register,
            style: TextStyle(
              fontSize: AppText.headingOne.fontSize,
              fontWeight: AppText.headingOne.fontWeight,
              color: AppColor.primary,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 37, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Consumer<RegisterViewModel>(
                builder: (context, model, child) {
                  return Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: localizations.email,
                          labelStyle: TextStyle(
                            color: AppColor.FieldLabel,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: model.emailError == null ? AppColor.primary : Colors.red, // Change border color based on email validation
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: model.emailError == null ? AppColor.primary : Colors.red, // Change border color based on email validation
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          errorText: model.emailError,
                        ),
                        onChanged: (value) {
                          model.setEmail(value);
                        },
                      ),
                      SizedBox(height: 45),
                      TextField(
                        controller: _passwordController,
                        obscureText: _isPasswordObscured,
                        decoration: InputDecoration(
                          labelText: localizations.password,
                          labelStyle: TextStyle(
                            color: AppColor.FieldLabel,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: model.passwordError == null ? AppColor.primary : Colors.red, // Change border color based on password validation
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: model.passwordError == null ? AppColor.primary : Colors.red, // Change border color based on password validation
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordObscured = !_isPasswordObscured;
                              });
                            },
                          ),
                          errorText: model.passwordError,
                        ),
                        onChanged: (value) {
                          model.setPassword(value);
                        },
                      ),
                      SizedBox(height: 45),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: _isConfirmPasswordObscured,
                        decoration: InputDecoration(
                          labelText: localizations.confirmPassword,
                          labelStyle: TextStyle(
                            color: AppColor.FieldLabel,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: model.confirmPasswordError == null ? AppColor.primary : Colors.red, // Change border color based on confirm password validation
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: model.confirmPasswordError == null ? AppColor.primary : Colors.red, // Change border color based on confirm password validation
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordObscured ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                              });
                            },
                          ),
                          errorText: model.confirmPasswordError,
                        ),
                        onChanged: (value) {
                          model.setConfirmPassword(value);
                        },
                      ),
                      SizedBox(height: 45),
                      Text(localizations.accountRole, style: TextStyle(
                        fontSize: AppText.headingsix.fontSize,
                        fontWeight: AppText.headingsix.fontWeight,
                      )),
                      ListTile(
                        title: Text(localizations.admin), // Use localized string
                        leading: Radio<String>(
                          value: 'Admin',
                          groupValue: model.selectedRole,
                          onChanged: (value) {
                            model.setSelectedRole(value!);
                          },
                          activeColor: AppColor.primary,
                        ),
                      ),
                      ListTile(
                        title: Text(localizations.manager), // Use localized string
                        leading: Radio<String>(
                          value: 'Manager',
                          groupValue: model.selectedRole,
                          onChanged: (value) {
                            model.setSelectedRole(value!);
                          },
                          activeColor: AppColor.primary,
                        ),
                      ),
                      ListTile(
                        title: Text(localizations.staff), // Use localized string
                        leading: Radio<String>(
                          value: 'Staff',
                          groupValue: model.selectedRole,
                          onChanged: (value) {
                            model.setSelectedRole(value!);
                          },
                          activeColor: AppColor.primary,
                        ),
                      ),
                      if (model.selectedRole != 'Manager')
                        buildContinueButton(),
                      if (model.selectedRole == 'Manager')
                        managerFields(model),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
      child: SizedBox(
        width: 204,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          ),
          onPressed: _handleFormSubmission,
          child: Text(localizations.continueText, style: AppText.ButtonText), // Changed text to localized string
        ),
      ),
    );
  }

  Widget managerFields(RegisterViewModel model) {
    return Column(
      children: [
        SizedBox(height: 45),
        TextField(
          controller: _businessNameController,
          decoration: InputDecoration(
            labelText: localizations.businessName, // Use localized string
            labelStyle: TextStyle(
              color: AppColor.FieldLabel,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: AppColor.primary,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: AppColor.primary,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          onChanged: (value) {
            model.setBusinessName(value);
          },
        ),
        SizedBox(height: 45),
        TextField(
          controller: _phoneNumberController,
          decoration: InputDecoration(
            labelText: localizations.phoneNumber, // Use localized string
            labelStyle: TextStyle(
              color: AppColor.FieldLabel,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: AppColor.primary,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: AppColor.primary,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          onChanged: (value) {
            model.setPhoneNumber(value);
          },
        ),
        SizedBox(height: 45),
        TextField(
          controller: _businessAddressController,
          decoration: InputDecoration(
            labelText: localizations.businessAddress, // Use localized string
            labelStyle: TextStyle(
              color: AppColor.FieldLabel,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: AppColor.primary,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: AppColor.primary,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          onChanged: (value) {
            model.setBusinessAddress(value);
          },
        ),
        SizedBox(height: 45),
        buildContinueButton(),
      ],
    );
  }
}