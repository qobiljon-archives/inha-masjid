// Stdlib
import 'package:flutter/material.dart';
import 'package:inha_masjid/ui/main/main_router.dart';

// Local
import 'package:inha_masjid/ui/welcome_screen.dart';
import 'package:inha_masjid/ui/record_donation_screen.dart';
import 'package:inha_masjid/ui/admin/admin_login_screen.dart';
import 'package:inha_masjid/ui/admin/admin_panel_screen.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/strings.dart';

void main() {
  runApp(const InhaMasjidApp());
}

class InhaMasjidApp extends StatelessWidget {
  const InhaMasjidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: AppStrings.appTitle,
      theme: ThemeData(
        colorSchemeSeed: AppColors.widgetPrimary,
        useMaterial3: true,
      ),

      // Main router widget checks if app is opened for the first time, and
      // redirects to welcome screen if so. Otherwise, it redirects to home screen.
      initialRoute: '/main',

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
