// All the strings used in the app are defined here. This is to make it easier to
// change the strings in the future. For example, if we want to change the app
// title, we can just change the string in this file, and it will be reflected
// in the entire app screens. This is also useful for adopting localization in
// the future (https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization).

// Stdlib
import 'package:intl/intl.dart';

/// Class for streamlining the UI strings used in the app (for consistency and
/// easier localization in the future).
class AppStrings {
  // Private constructor to prevent instances from this class
  AppStrings._();

  // Formatters
  static final _numberFmt = NumberFormat("###,###", "en_US");

  // General strings
  static const String appTitle = 'Inha Masjid';
  static const String inhaMasjidAdmin = 'Inha Masjid Admin';

  // Home screen strings
  static const String home = 'Home';
  static const String areYouAdmin = 'Are you masjid administrator?';
  static const String goToAdmin = 'Go to admin page';
  static const String goal = 'Goal';
  static const String donate = 'Donate';
  static const String activityFeed = 'Activity feed';
  static const String currentProgress = 'Current progress';

  static String raisedAmount(int amount, String currency) {
    // Raised amount: 12,345 KRW
    return 'Raised ${_numberFmt.format(amount)} ${currency.toUpperCase()}';
  }

  static String requiredAmount(int amount, String currency) {

    // Construct the amount part
    var ans = 'out of ';
    if (amount >= 1000000) {
      // 1.2m
      ans += '${amount ~/ 1000000}m';
    } else if (amount >= 1000) {
      // 900k
      ans += '${amount ~/ 1000}k';
    } else {
      // 100
      ans += '$amount';
    }

    // Attach the currency
    ans += ' ${currency.toUpperCase()}';

    // Return the string: "out of 1.2m KRW"
    return ans;
  }

  static String donationForMonth(int month, int year) {
    return "For Inha Masjid's monthly rent for $month, $year.";
  }

  // Prayer times screen strings
  static const String prayerTimes = 'Prayer times';
  static const String announcements = 'Announcements';

  // Admin login screen
  static const String loginPrompt = 'Great to have you back! Login';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String login = 'Login';

  // Admin panel screen
  static const String updateMonthlyExpenseAmount = 'Update Masjid’s monthly expenses';
  static const String updatePrayerTimes = 'Update prayer times';
  static const String update = 'Update';
  static const String postNewAnnouncement = 'Post new announcement';
  static const String adminPanelUpdatePostButtonText = 'Post';

  // Record donation screen
  static const String recordMyDonation = 'Record my donation';
  static const String bankAccountNumber = 'Masjid bank account';
  static const String donationDetails = 'Donation details';
  static const String donationDetailsAmount = '0 ₩';
  static const String donatedAmountOne = '10.000 ₩';
  static const String donatedAmountTwo = '20.000 ₩';
  static const String donatedAmountThree = '30.000 ₩';
  static const String donatedAmountFour = '40.000 ₩';
  static const String recordMyDonationDonateNameText = 'Donor Name';
  static final String recordMyDonationButtonText = 'Record'.toUpperCase();
  static const String recordMyDonationSenderName = 'Sender name';

  // Update Masjid bank account title
  static const String updateMasjidBankAccountTitle = 'Update Masjid\'s bank account';
  static final String updateMasjidBankAccountButtonText = 'Update'.toUpperCase();

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
  // static final List<Map<String, dynamic>> items = List.generate(
  //   3,
  //   (index) => {
  //     "id": index,
  //     "title": "Item $index",
  //     "content":
  //         "We regularly update you with Masjid's latest news, programs and other related announcements in this page",
  //     "date": "2023-12-20", // Replace with your actual date
  //   },
  // );

  // Prayer names list (for admin panel and prayer times on main screen)
  static const List<String> prayerNames = [
    'fajr',
    'dhuhr',
    'asr',
    'maghrib',
    'isha',
  ];
}
