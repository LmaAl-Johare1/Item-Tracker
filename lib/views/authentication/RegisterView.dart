import 'package:flutter/material.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import 'package:project/services/network_service.dart';
import '../../utils/validators.dart';
import '../../viewmodels/authentication/RegisterViewModel.dart';

/// A StatefulWidget responsible for displaying the registration form.
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

/// The state for the RegisterPage widget.
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

  /// Handles the form submission.
  void _handleFormSubmission() {
    if (!Validator.validateEmail(_emailController.text)) {
      _showSnackBar('Invalid email address');
      return;
    }

    if (!Validator.validatePassword(_passwordController.text)) {
      _showSnackBar('Password should be at least 6 characters long');
      return;
    }

    if (!Validator.validatePasswordMatch(
        _passwordController.text, _confirmPasswordController.text)) {
      _showSnackBar('Passwords do not match');
      return;
    }
    if (!Validator.validatePhoneNumber(_phoneNumberController.text)) {
      _showSnackBar('Invalid phone number');
      return;
    }
    _registerViewModel.setEmail(_emailController.text);
    _registerViewModel.setPassword(_passwordController.text);
    _registerViewModel.setConfirmPassword(_confirmPasswordController.text);
    _registerViewModel.setSelectedRole(_selectedRole);
    _registerViewModel.setBusinessName(_businessNameController.text);
    _registerViewModel.setPhoneNumber(_phoneNumberController.text);
    _registerViewModel.setBusinessAddress(_businessAddressController.text);

    _registerViewModel.signUp();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _businessNameController.clear();
    _phoneNumberController.clear();
    _businessAddressController.clear();
  }

  /// Shows a SnackBar with the provided message.
  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Register',
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
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: AppColor.FieldLabel,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Validator.validateEmail(_emailController.text) ? AppColor.primary : Colors.red, // Change border color based on email validation
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Validator.validateEmail(_emailController.text) ? AppColor.primary : Colors.red, // Change border color based on email validation
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(height: 45),
            TextField(
              controller: _passwordController,
              obscureText: _isPasswordObscured,
              decoration: InputDecoration(
                errorText: !Validator.validatePassword(_passwordController.text)
                    ? 'Password should be at least 6 characters long'
                    : null,
                labelText: 'Password',
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
              ),
            ),
            SizedBox(height: 45),
            TextField(
              controller: _confirmPasswordController,
              obscureText: _isConfirmPasswordObscured,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
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
              ),
            ),
            SizedBox(height: 45),
            Text(
              'Account Role',
              style: TextStyle(
                fontSize: AppText.headingsix.fontSize,
                fontWeight: AppText.headingsix.fontWeight,
              ),
            ),
            SizedBox(height: 45),
            Text('Account Role', style: TextStyle(
              fontSize: AppText.headingsix.fontSize,
              fontWeight: AppText.headingsix.fontWeight,
            )),
            ListTile(
              title: const Text('Admin'),
              leading: Radio<String>(
                value: 'Admin',
                groupValue: _selectedRole,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                activeColor: AppColor.primary,
              ),
            ),
            ListTile(
              title: const Text('Manager'),
              leading: Radio<String>(
                value: 'Manager',
                groupValue: _selectedRole,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                activeColor: AppColor.primary,
              ),
            ),
            ListTile(
              title: const Text('Staff'),
              leading: Radio<String>(
                value: 'Staff',
                groupValue: _selectedRole,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                activeColor: AppColor.primary,
              ),
            ),
            if (_selectedRole != 'Manager')
              buildContinueButton(),
            if (_selectedRole == 'Manager')
              managerFields(),
          ],
        ),
      ),
    );
  }

  /// Builds the Continue button widget.
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
          onPressed: () {
            _handleFormSubmission(); // Call the handleFormSubmission method
          },
          child: Text('Continue', style: AppText.ButtonText),
        ),
      ),
    );
  }

  /// Builds the additional fields for the Manager role.
  Widget managerFields() {
    return Column(
      children: [
        SizedBox(height: 45),
        TextField(
          controller : _businessNameController,
          decoration: InputDecoration(
            labelText: 'Business Name',
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
        ),
        SizedBox(height: 45),
        TextField(
          controller : _phoneNumberController,
          decoration: InputDecoration(
            labelText: 'Phone Number',
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
        ),
        SizedBox(height: 45),
        TextField(
          controller : _businessAddressController,
          decoration: InputDecoration(
            labelText: 'Business address',
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
        ),
        SizedBox(height: 45),
        buildContinueButton(),
      ],
    );
  }
}
