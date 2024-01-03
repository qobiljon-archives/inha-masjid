// Masjid admin user login screen. This screen is used to login to the admin
// panel. The screen includes email and password input fields and a login button.
// Upon successful login, the user is redirected to the admin panel screen.

// Stdlib
import 'package:flutter/material.dart';

// 3rd party
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Local
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';

/// Login screen widget for Masjid admin users.
class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});

  // Variables
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Functions
  void _loginBtnPressed(BuildContext context) {
    // Get email and password from input fields
    var email = _emailController.text;
    var password = _passwordController.text;

    // Submit email and password to Firebase auth
    var auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      Fluttertoast.showToast(
        msg: 'Login successful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacementNamed(context, '/admin_panel');
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: 'Invalid email or password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(error);
    });
  }

  // Overrides
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // need logic
          },
        ),
        title: Text(
          AppStrings.adminLoginScreenTitle,
          style: GoogleFonts.manrope(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimensions.screenTitleFontSize,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Login screen icon
              const Icon(
                Icons.admin_panel_settings,
                size: AppDimensions.adminLoginIconFontSize,
                color: AppColors.widgetPrimary,
              ),
              const SizedBox(height: 50),

              // Login screen subtitle
              Text(
                AppStrings.adminLoginTitle,
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Email input field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SafeArea(
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: AppStrings.adminEmailHintText,
                      hintStyle: const TextStyle(
                        color: AppColors.textSecondary,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.cardBackgroundColor,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.cardButtonBackgroundColor,
                        ),
                      ),
                      fillColor: AppColors.white,
                      filled: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Password input field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.adminPasswordHintText,
                    hintStyle: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.cardBackgroundColor,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.cardButtonBackgroundColor,
                      ),
                    ),
                    fillColor: AppColors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Login button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextButton(
                  onPressed: () => _loginBtnPressed(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(18.0), // Add padding
                    backgroundColor: AppColors
                        .cardButtonBackgroundColor, // Set background color
                  ),
                  child: Text(
                    AppStrings.adminLoginButtonText,
                    style: GoogleFonts.manrope(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.adminLoginButtonTextSize,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
