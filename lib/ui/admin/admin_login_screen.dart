// TODO: write documentation

// Stdlib
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inha_masjid/ui/admin/admin_panel_screen.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';

/// TODO: write documentation
class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({
    super.key,
  });

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

/// TODO: write documentation
class _AdminLoginScreenState extends State<AdminLoginScreen> {
  // Add controllers for the text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.admin_panel_settings,
              size: AppDimensions.adminLoginIconFontSize,
              color: AppColors.widgetPrimary,
            ),
            const SizedBox(height: 50),
            Text(
              AppStrings.adminLoginTitle,
              style: GoogleFonts.manrope(
                textStyle: const TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: AppStrings.adminLoginHintText,
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminPanelScreen(),
                    ),
                  );
                },
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
          ],
        ),
      ),
    );
  }
}
