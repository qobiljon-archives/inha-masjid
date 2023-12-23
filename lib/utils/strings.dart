// All the strings used in the app are defined here. This is to make it easier to
// change the strings in the future. For example, if we want to change the app
// title, we can just change the string in this file, and it will be reflected
// in the entire app screens. This is also useful for adopting localization in
// the future (https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization).

/// Class for streamlining the UI strings used in the app (for consistency and
/// easier localization in the future).
class AppStrings {
  // Private constructor to prevent instances from this class
  AppStrings._();

  // Strings
  static const String appTitle = 'Inha Masjid';
  // Home screen strings
  static const String homeScreenTitle = 'Home screen';
  static const String homeScreenCardQuestion = 'Are you masjid administrator?';
  static final String homeScreenCardTextButton =
      'Go to admin page'.toUpperCase();
  static const String homeScreenRequiredAvarageAmount =
      'Required average amount';
  static const String homeScreenTotalAmount = '2.000.000 ₩';
  static const String homeScreenCollectedAmountText = 'Collected amount';
  static const String homeScreenCollectedAmount = '700.000 ₩';
  static final String homeScreenRecordDonation =
      'Record my donation'.toUpperCase();
  static const String transactionHistoryTitle = 'Ot****';
  static const String transactionHistoryDate = 'Monday, 11 December';
  static const String transactionHistoryTotalSent = '20.000 ₩';
  // Prayer times screen strings
  static const String prayerTimesScreenTitle = 'Prayer times';
  static const String announcementsScreenTitle = 'Announcements';
  // Admin Login Screen
  static const String adminLoginScreenTitle = 'Inha Masjid Admin';
  static const String adminLoginTitle = 'Great to have you back! Login';
  static const String adminLoginHintText = 'Username';
  static const String adminPasswordHintText = 'Password';
  static final String adminLoginButtonText = 'Login'.toUpperCase();

  // Admin Panel Screen
  static const String adminPanelScreenAppBarTitle = 'Inha Masjid Admin';
  static const String adminPanelUpdateMonthlyText =
      'Update Masjid’s monthly expenses';
  static const String adminPanelUpdatePrayerTimesText = 'Update prayer times';
  static const String adminPanelUpdateMonthlyExpenseAmount = '2.000.000';
  static const String adminPanelUpdateMonthlyExpenseWonText = '₩';
  static final String adminPanelButtonText = 'Update'.toUpperCase();
  static const String adminPanelUpdatePostText = 'Post new announcement';
  static final String adminPanelUpdatePostButtonText = 'Post'.toUpperCase();
  static final String adminPanelUpdateExitButtonText = 'Exit'.toUpperCase();

  static const String masjidBankAccountTitle = 'Record My Donation';
  static const String masjidBankAccountText = 'Masjid bank account';
  static const String masjidBankAccountType = 'Kookmin Bank';
  static const String masjidBankAccountNumber = '64680101486242';
  static const String masjidBankAccountDonationDetails = 'Donation details';
  static const String donationDetailsAmount = '0 ₩';
  static const String donatedAmountOne = '10.000 ₩';
  static const String donatedAmountTwo = '20.000 ₩';
  static const String donatedAmountThree = '30.000 ₩';
  static const String donatedAmountFour = '40.000 ₩';
  static const String recordMyDonationDonateNameText = 'Donor Name';
  static final String recordMyDonationButtonText = 'Record'.toUpperCase();
  static const String recordMyDonationSenderName = 'Sender name';

  // String lists
  static const List<String> welcomeScreenTitles = [
    'Welcome', // Welcome screen 1 title
    'Prayer Times', // Welcome screen 2 title
    'Announcements', // Welcome screen 3 title
    'Masjid Administration', // Welcome screen 4 title
  ];
  static const List<String> welcomeScreenDescriptions = [
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
  // announcements screen default data
  static final List<Map<String, dynamic>> items = List.generate(
    3,
    (index) => {
      "id": index,
      "title": "Item $index",
      "content":
          "We regularly update you with Masjid's latest news, programs and other related announcements in this page",
      "date": "2023-12-20", // Replace with your actual date
    },
  );

  // prayer times list
  static final List<Map<String, String>> prayerTimes = [
    {'name': 'Fajr', 'time': '06:45'},
    {'name': 'Sunrise', 'time': '7:39'},
    {'name': 'Dhuhr', 'time': '1:15'},
    {'name': 'Asr', 'time': '15:45'},
    {'name': 'Maghrib', 'time': '17:22'},
    {'name': 'Isha', 'time': '20:00'},
  ];
}
