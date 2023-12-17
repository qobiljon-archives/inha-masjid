// All paths for assets used in the app (images, fonts, etc.) are defined here.
// This is to prevent typos and to make it easier to change the path of an asset.

/// Class for streamlining access to application assets (paths)
class AppAssets {
  // Private constructor to prevent instances from this class
  AppAssets._();

  // region Image asset paths

  // Application logo
  static const String logoLight = 'lib/assets/images/logo/logo_light.png';
  static const String logoDark = 'lib/assets/images/logo/logo_dark.png';

  // Welcome screen illustrations
  static const String welcomeIllustration1 =
      'lib/assets/images/welcome_illustrations/1.png';
  static const String welcomeIllustration2 =
      'lib/assets/images/welcome_illustrations/2.png';
  static const String welcomeIllustration3 =
      'lib/assets/images/welcome_illustrations/3.png';
  static const String welcomeIllustration4 =
      'lib/assets/images/welcome_illustrations/4.png';

  // endregion

  // region Image asset groups

  static const List<String> welcomeIllustrations = [
    welcomeIllustration1,
    welcomeIllustration2,
    welcomeIllustration3,
    welcomeIllustration4,
  ];

// endregion
}
