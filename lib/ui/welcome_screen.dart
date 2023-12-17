// Welcome screen shown when user opens the app for the first time. This screen
// includes a welcome message, and three other tutorial screens with title,
// description, and illustration image. The user can navigate through the
// tutorial screens using the next and previous buttons, and can start using
// the application by clicking the start button on the last tutorial screen.

// Stdlib
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Local
import 'package:inha_masjid/utils/assets.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Welcome screen shown when user opens the app for the first time.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

/// Welcome screen state that switches between four tutorial screens.
/// - Welcome screen 1: Welcoming message.
/// - Welcome screen 2: Prayer times functionality.
/// - Welcome screen 3: Announcements functionality.
/// - Welcome screen 4: Masjid administration functionality.
class _WelcomeScreenState extends State<WelcomeScreen> {
  // Index of current welcome screen contents in range [0, 3]
  // The range is derived from `AppAssets.welcomeIllustrations.length`
  int _curScreenIdx = 0;

  /// Switches to previous welcome screen upon clicking the previous button.
  void _previousClick() {
    setState(() => _curScreenIdx--);
  }

  /// Switches to next welcome screen upon clicking the next button.
  void _nextClick() {
    if (_curScreenIdx == AppAssets.welcomeIllustrations.length - 1) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('firstTime', false);
        Navigator.pushReplacementNamed(context, '/home');
      });
    } else {
      setState(() => _curScreenIdx++);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 3),

            // Logo at the top
            const FractionallySizedBox(
              widthFactor: AppDimensions.imgWelcomeLogoFactor,
              child: Image(image: AssetImage(AppAssets.logoDark)),
            ),

            const Spacer(),

            // Square image in the middle with illustration
            FractionallySizedBox(
              widthFactor: AppDimensions.imgWelcomeIllustrationFactor,
              child: Image(
                image: AssetImage(
                  AppAssets.welcomeIllustrations[_curScreenIdx],
                ),
              ),
            ),

            const Spacer(),

            // Title of current welcome screen
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                AppStrings.welcomeScreenTitles[_curScreenIdx],
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            // Description of current welcome screen
            Text(
              AppStrings.welcomeScreenDescriptions[_curScreenIdx],
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),

            const Spacer(flex: 3),

            // Dots displaying current welcome screen
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < AppAssets.welcomeIllustrations.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: i == _curScreenIdx ? 12 : 8,
                      height: i == _curScreenIdx ? 12 : 8,
                      decoration: BoxDecoration(
                        color: i == _curScreenIdx
                            ? AppColors.widgetSecondary
                            : AppColors.widgetSecondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
              ],
            ),

            const Spacer(flex: 3),

            // Button to go to previous or next welcome screens
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Previous button
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _curScreenIdx != 0,
                  child: TextButton(
                    onPressed: _previousClick,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: AppColors.widgetLightPrimary,
                          ),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 5,
                      ),
                      child: Text(
                        'Previous'.toUpperCase(),
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.widgetLightPrimary,
                        ),
                      ),
                    ),
                  ),
                ),

                // Next button
                TextButton(
                  onPressed: _nextClick,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(
                          color: AppColors.widgetLightPrimary,
                        ),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll<Color>(
                      AppColors.widgetLightPrimary,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 5,
                    ),
                    child: Text(
                      _curScreenIdx == AppAssets.welcomeIllustrations.length - 1
                          ? 'Start'.toUpperCase()
                          : 'Next'.toUpperCase(),
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
