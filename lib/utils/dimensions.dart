// All dimensions used in the app (logo sizes, button sizes, paddings, etc.) are
// are defined here. This is to ensure that the app is responsive and consistent
// across all app screens and devices.

/// Class for streamlining the use of dimensions in the app (for consistency across
/// all screens and devices, easy maintenance, and app UI responsiveness).
class AppDimensions {
  // Private constructor to prevent instances from this class
  AppDimensions._();

  // Dimensions (primarily taken from Figma prototype)
  // ref: https://www.figma.com/file/sflifKnmkstz8j02emIXMS/Inha-Masjid-draft-(work-on-this)?type=design&node-id=0%3A1&mode=design&t=UmlmHZfCo964xBvV-1

  // ref Figma prototype: 172x80 logo in 393x852 container
  static const double imgSplashLogoFactor = 172 / 393;

  // ref Figma prototype: 48.8x60.22 logo in 393x852 container
  static const double imgWelcomeLogoFactor = 48.8 / 393;

  // ref Figma prototype: 329x329 square image in 393x393 container
  static const double imgWelcomeIllustrationFactor = 329 / 393;

  // ref Figma prototype: 168x56 button in 393x852 container
  static const double btnWelcomeNavWidthFactor = 168 / 393;
  static const double btnWelcomeNavHeightFactor = 56 / 852;
}
