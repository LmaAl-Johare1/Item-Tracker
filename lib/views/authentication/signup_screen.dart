import 'package:flutter/material.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/res/AppText.dart';
import 'package:project/views/authentication/login_screen.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _selectedRole = 'Manager'; // Default to Manager as selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Register', style: TextStyle(
          fontSize: AppText.headingOne.fontSize,
          fontWeight: AppText.headingOne.fontWeight,
          color: AppColor.primary,
        )),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 37, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
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
              decoration: InputDecoration(
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
              ),
            ),
            SizedBox(height: 45),
            TextField(
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
                    // Rebuild the widget to update the Continue button's position
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
                    // Rebuild the widget to update the Continue button's position
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
                    // Rebuild the widget to update the Continue button's position
                  });
                },
                activeColor: AppColor.primary,
              ),
            ),
            if (_selectedRole != 'Manager')  // If not Manager, show Continue here
              buildContinueButton(),
            if (_selectedRole == 'Manager')  // Show Manager fields and button if Manager
              managerFields(),
          ],
        ),
      ),
    );
  }

  Widget buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30,horizontal:60), // Horizontal padding
      child: SizedBox(
        width: 204, // Set the fixed width
        height: 55, // Set the fixed height
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, // Text color
            backgroundColor: AppColor.primary, // Background color from AppColor
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50), // Padding inside the button
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),  // Navigate to LoginPage
            );
          },
          child: Text('Continue', style: AppText.ButtonText), // Using AppText styles for button text
        ),
      ),
    );
  }

  Widget managerFields() {
    return Column(
      children: [
        SizedBox(height: 45),
        TextField(
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
        buildContinueButton(), // Finally show Continue button
      ],
    );
  }
}
