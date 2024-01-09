// All the strings used in the app are defined here. This is to make it easier to
// change the strings in the future. For example, if we want to change the app
// title, we can just change the string in this file, and it will be reflected
// in the entire app screens. This is also useful for adopting localization in
// the future (https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization).

// Stdlib
import 'package:inha_masjid/utils/extensions.dart';
import 'package:intl/intl.dart';

/// Class for streamlining the UI strings used in the app (for consistency and
/// easier localization in the future).
class AppStrings {
  // Private constructor to prevent instances from this class
  AppStrings._();

  // General strings
  static const String appTitle = 'Inha Masjid';
  static const String inhaMasjidAdmin = 'Inha Masjid Admin';

  // Home screen strings
  static const String home = 'Home';
  static const String areYouAdmin = 'Are you masjid administrator?';
  static const String goToAdmin = 'Go to admin page';
  static const String goal = 'Goal';
  static const String donate = 'Donate to Inha Masjid';
  static const String activityFeed = 'Activity feed';
  static const String noDonations =
      'No donations yet. Make the difference by making a donation now!';
  static const String rentUpdatedMessage = 'Monthly rent amount updated successfully';
  static const String rentUpdateFailedMessage =
      'Monthly rent amount must be a number (e.g., 1000000)';
  static const String prayerTimeUpdateCanceledMessage = 'Prayer time update canceled';

  static get currentProgress {
    String ans = 'Raising for ';

    // Prepare next month name
    DateTime now = DateTime.now();
    DateTime nextMonth = DateTime(now.year, now.month + 1, 1);
    DateFormat df = DateFormat.yMMM(); // e.g., "Jan 2021"

    // Add next month name
    ans += df.format(nextMonth);

    // return the string
    return ans; // e.g., "Raising for Jan 2021"
  }

  static String prayerTimeUpdatedMessage(String prayerName) =>
      '$prayerName prayer time  updated successfully';

  static String raisedAmount(int amount, {bool addCurrency = false}) {
    var ans = 'raised ';

    // add the amount
    ans += amount.commaSeparated();

    // add the currency
    if (addCurrency) {
      ans += '원';
    }

    return ans; // e.g., "Raised amount: 12,345"
  }

  static String requiredAmount(int amount, {bool addCurrency = false}) {
    var ans = '/';

    // add the amount
    ans += amount.commaSeparated();

    // add the currency
    if (addCurrency) {
      ans += '원';
    }

    return ans; // e.g., "out of 1.2m ₩"
  }

  // Prayer times screen strings
  static const String prayerTimes = 'Prayer times';
  static const String announcements = 'Announcements';

  // Admin login screen
  static const String loginPrompt = 'Great to have you back! Login';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String login = 'Login';
  static const String announcementTitle = 'Title';
  static const String announcementTitleTooltip = 'e.g., Taraweeh prayer tonight at 8:30pm';
  static const String announcementBody = 'Body';
  static const String announcementBodyTooltip =
      'e.g., Dear brothers, we will be having Taraweeh prayer tonight at 8:30pm. Please join us.';

  // Admin panel screen
  static const String updateMonthlyExpenseAmount = 'Update Masjid’s monthly expenses';
  static const String updatePrayerTimes = 'Update prayer times';
  static const String update = 'Update';
  static const String postNewAnnouncement = 'Post new announcement';
  static const String adminPanelUpdatePostButtonText = 'Post';
  static const String amount = 'Amount';
  static const String amountTooltip = 'e.g., 1000000';
  static const String bankName = 'Bank name';
  static const String bankNameTooltip = 'e.g., Hana';
  static const String bankNumber = 'Bank number';
  static const String bankNumberTooltip = 'e.g., 748123123123123';

  // Record donation screen
  static const String bankAccountNumber = 'Inha Masjid\'s bank account';
  static const String donationAmount = 'Donation amount';
  static const String donationAmountTooltip = 'e.g., 9000원';
  static const String donatedAmountOne = '₩10.000';
  static const String donatedAmountTwo = '₩20.000';
  static const String donatedAmountThree = '₩30.000';
  static const String donatedAmountFour = '₩40.000';
  static const String donorName = 'Who is donating';
  static const String donorNameSub = '(leave blank to stay anonymous)';
  static const String donorNameTooltip = 'e.g., Bilal Ahmed';
  static final String recordMyDonationButtonText = 'Record my donation'.toUpperCase();

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

class FirestorePaths {
  // Documents
  static const String bankAccountDoc = '/masjidConfigs/bankAccount';
  static const String monthlyRentDoc = '/masjidConfigs/monthlyRent';

  static String prayerTimeDoc(String prayerName) => '/prayerTimes/$prayerName';

  // Collections
  static const String announcementsCol = '/announcements';
  static const String donationsCol = '/donations';
}
