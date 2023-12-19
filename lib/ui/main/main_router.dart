// Main router widget. This is the main widget that is used to switch between
// three main screens: home, prayer times, and announcements.

// Stdlib
import 'package:flutter/material.dart';

// 3rd party
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inha_masjid/ui/announcements_screen.dart';

// Local
import 'package:inha_masjid/ui/main/home_screen.dart';
import 'package:inha_masjid/ui/main/prayer_times_screen.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';

/// Main router widget for three main screens: home, prayer times, and announcements.
class MainRouterWidget extends StatefulWidget {
  const MainRouterWidget({super.key});

  @override
  State<MainRouterWidget> createState() => _MainRouterWidgetState();
}

/// Main router widget state that switches between three main screens: home, prayer
/// times, and announcements using a bottom navigation bar. The screen instances
/// are stored in a list of widgets, and referred to by index in build() method.
class _MainRouterWidgetState extends State<MainRouterWidget> {
  // Variables
  final List<Widget> _tabs = <Widget>[
    const PrayerTimesScreen(), // Prayer times screen (left tab)
    const HomeScreen(), // Home screen (center tab)
    const AnnouncementsScreen(), // Announcements screen (right tab)
  ];
  int _currentTabIdx = 1; // Default to home screen

  // Methods
  void _onTabChange(int index) {
    setState(() => _currentTabIdx = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentTabIdx],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(top: 0, left: 28, right: 28, bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.widgetLightPrimary,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 4, left: 29, right: 28, bottom: 4),
          child: GNav(
            backgroundColor: AppColors.widgetLightPrimary,
            color: AppColors.white,
            activeColor: AppColors.widgetLightPrimary,
            tabBackgroundColor: AppColors.white,
            iconSize: AppDimensions.bottomNavigationBarIconSize,
            selectedIndex: _currentTabIdx,
            tabs: const [
              GButton(icon: Icons.timer),
              GButton(icon: Icons.home),
              GButton(icon: Icons.notification_important),
            ],
            onTabChange: _onTabChange,
          ),
        ),
      ),
    );
  }
}
