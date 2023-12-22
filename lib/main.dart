// Stdlib
import 'package:flutter/material.dart';
import 'package:inha_masjid/ui/main/main_router.dart';

// 3rd party
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

// Local: UI screens
import 'package:inha_masjid/ui/welcome_screen.dart';
import 'package:inha_masjid/ui/record_donation_screen.dart';
import 'package:inha_masjid/ui/admin/admin_login_screen.dart';
import 'package:inha_masjid/ui/admin/admin_panel_screen.dart';

// Local: utilities
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/assets.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';

/// Entry point of the application
void main() {
  runApp(const InhaMasjidApp());
}

/// Main application widget
class InhaMasjidApp extends StatelessWidget {
  const InhaMasjidApp({super.key});

  /// Screen route function that identifies next screen after splash screen
  /// Checks if it is user's first time opening the application.
  /// Welcome screen shown when user opens the app for the first time.
  /// After that, welcome page immediately redirects to home screen.
  Future<String> _splashScreenRouteFunction() async {
    var prefs = await SharedPreferences.getInstance();
    final firstTime = prefs.getBool('firstTime') ?? true;
    return firstTime ? '/welcome' : '/main';
  }

  /// Main build function of the application. This includes the application theme,
  /// splash screen, and routes for easy navigation through the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: AppStrings.appTitle,
      theme: ThemeData(
        colorSchemeSeed: AppColors.widgetPrimary,
        useMaterial3: true,
      ),

      // Splash screen
      home: AnimatedSplashScreen.withScreenRouteFunction(
        backgroundColor: AppColors.widgetPrimary,
        splash: const Center(
          child: FractionallySizedBox(
            widthFactor: AppDimensions.imgSplashLogoFactor,
            child: Image(image: AssetImage(AppAssets.logoLight)),
          ),
        ),
        screenRouteFunction: _splashScreenRouteFunction,
      ),

      // Routes for easy navigation through the application
      routes: {
        // Welcome screen shown when user opens the app for the first time.
        // After that, welcome page immediately redirects to home screen.
        '/welcome': (context) => const WelcomeScreen(),

        // Home page, shown immediately after splash screen (or instructions on first time)
        '/main': (context) => const MainRouterWidget(),

        // Donation recording Screen (regular user)
        '/donate': (context) => const RecordDonationScreen(),

        // Admin login Screen (admin user)
        '/admin_login': (context) => const AdminLoginScreen(),

        // Administration Screen for configuring masjid details (admin user)
        '/admin_panel': (context) => const AdminPanelScreen(),
      },
    );
  }
}
