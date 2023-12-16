// Welcome screen shown when user opens the app for the first time.

// Stdlib
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Local
import 'package:inha_masjid/utils/assets.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
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
  // List of illustration images for each welcome screen.
  final List<String> _illustrationImages = [
    // Welcome screen 1 illustration
    AppAssets.welcomeIllustration1,

    // Welcome screen 2 illustration
    AppAssets.welcomeIllustration2,

    // Welcome screen 3 illustration
    AppAssets.welcomeIllustration3,

    // Welcome screen 4 illustration
    AppAssets.welcomeIllustration4,
  ];

  // List of titles for each welcome screen.
  final List<String> _titles = [
    // Welcome screen 1 title
    'Welcome',

    // Welcome screen 2 title
    'Prayer Times',

    // Welcome screen 3 title
    'Announcements',

    // Welcome screen 4 title
    'Masjid Administration',
  ];

  // List of descriptions for each welcome screen.
  final List<String> _descriptions = [
    // Welcome screen 1 description
    '''
    A digital space for our community, where
    your donations contrib ute to essential
    monthly expenses of 2 million.
    ''',

    // Welcome screen 2 description
    '''
    Stay connected with daily prayer times
    ensuring you're always updated with
    the changing schedule at Inha Masjid.
    ''',

    // Welcome screen 3 description
    '''
    Get the latest updates and key info
    from Inha Masjid, staying informed and
    connected with our community.
    ''',

    // Welcome screen 4 description
    '''
    Admin handles Masjid’s donation account,
    prayer times, and announcement postings
    in the app.
    ''',
  ];

  // Screen index of the current welcome screen.
  int _currentScreenIdx = 0;

  // Navigation functions
  void _previousClicked() {
    setState(() {
      _currentScreenIdx--;
    });
  }

  void _nextClicked() {
    if (_currentScreenIdx == _illustrationImages.length - 1) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('firstTime', false);
        Navigator.pushReplacementNamed(context, '/home');
      });
    } else {
      setState(() => _currentScreenIdx++);
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
              widthFactor: AppDimensions.welcomeLogoFactor,
              child: Image(image: AssetImage(AppAssets.logoDark)),
            ),

            const Spacer(),

            // Square image in the middle with illustration
            FractionallySizedBox(
              widthFactor: AppDimensions.welcomeImageFactor,
              child: Image(
                  image: AssetImage(_illustrationImages[_currentScreenIdx])),
            ),

            const Spacer(),

            // Title of current welcome screen
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                _titles[_currentScreenIdx],
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            // Description of current welcome screen
            Text(
              _descriptions[_currentScreenIdx],
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
                for (int i = 0; i < _illustrationImages.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: i == _currentScreenIdx ? 12 : 8,
                      height: i == _currentScreenIdx ? 12 : 8,
                      decoration: BoxDecoration(
                        color: i == _currentScreenIdx
                            ? AppColors.welcomeScreenDot
                            : AppColors.welcomeScreenDot.withOpacity(0.1),
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
                  visible: _currentScreenIdx != 0,
                  child: TextButton(
                    onPressed: _previousClicked,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: AppColors.welcomeScreenButtonColor,
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
                          color: AppColors.welcomeScreenButtonColor,
                        ),
                      ),
                    ),
                  ),
                ),

                // Next button
                TextButton(
                  onPressed: _nextClicked,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(
                          color: AppColors.welcomeScreenButtonColor,
                        ),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll<Color>(
                      AppColors.welcomeScreenButtonColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 5,
                    ),
                    child: Text(
                      _currentScreenIdx == _illustrationImages.length - 1
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
