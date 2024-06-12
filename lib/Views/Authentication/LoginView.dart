import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModels/Authentication/LoginViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    localizations.login,
                    style: AppText.headingOne.copyWith(
                      color: AppColor.primary,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/img/logo.png',
                  width: 380,
                  height: 387,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Consumer<LoginViewModel>(
                    builder: (context, model, child) {
                      return Column(
                        children: [
                          TextField(
                            controller: _emailController,
                            decoration: _buildInputDecoration(
                              localizations.email,
                              model.emailError,
                            ),
                            onChanged: (value) {
                              model.setEmail(value);
                            },
                          ),
                          if (model.emailError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                            ),
                          SizedBox(height: 35),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _isObscured,
                            decoration: _buildInputDecoration(
                              localizations.password,
                              model.passwordError,
                              suffixIcon: IconButton(
                                icon: Icon(_isObscured ? Icons.visibility_off: Icons.visibility),
                                color: Colors.grey,

                                onPressed: () {
                                  setState(() {
                                    _isObscured = !_isObscured;
                                  });
                                },
                              ),
                            ),
                            onChanged: (value) {
                              model.setPassword(value);
                            },
                          ),
                          if (model.passwordError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/resetPassword');
                        },
                        child: Text(
                          localizations.forgetPassword,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    width: 209,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      onPressed: () => _handleLogin(context),
                      child: Text(
                        localizations.login,
                        style: AppText.ButtonText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String labelText, String? errorText, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
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
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      errorText: errorText,
      suffixIcon: suffixIcon,
    );
  }

  void _handleLogin(BuildContext context) async {
    final model = Provider.of<LoginViewModel>(context, listen: false);
    model.setEmail(_emailController.text);
    model.setPassword(_passwordController.text);

    await model.login(context);

    if (model.emailError == null && model.passwordError == null) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      _showSnackBar(model.emailError ?? model.passwordError ?? 'Error');
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
