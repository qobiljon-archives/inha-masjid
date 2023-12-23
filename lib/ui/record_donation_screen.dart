// TODO: write documentation

// Stdlib
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';

/// TODO: write documentation
class RecordDonationScreen extends StatefulWidget {
  const RecordDonationScreen({super.key});

  @override
  State<RecordDonationScreen> createState() => _RecordDonationScreenState();
}

/// TODO: write documentation
class _RecordDonationScreenState extends State<RecordDonationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppStrings.masjidBankAccountTitle,
          style: GoogleFonts.manrope(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                AppStrings.masjidBankAccountText,
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.masjidBankAccountTitleSize,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: AppColors.cardBackgroundColor,
              elevation: AppDimensions.cardElevation,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/bank_logo/kookmin.png',
                      width: 52,
                    ),
                    Text(
                      AppStrings.masjidBankAccountType,
                      style: GoogleFonts.manrope(
                        textStyle: const TextStyle(
                          fontSize: AppDimensions.masjidBankAccountCardFontSize,
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                    Text(
                      AppStrings.masjidBankAccountNumber,
                      style: GoogleFonts.manrope(
                        textStyle: const TextStyle(
                          fontSize: AppDimensions.masjidBankAccountCardFontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Copy Account Number',
                      style: GoogleFonts.manrope(
                        fontSize: AppDimensions.recordMyDonationSmallFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                AppStrings.masjidBankAccountDonationDetails,
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.masjidBankAccountTitleSize,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppStrings.donationDetailsAmount,
                  hintStyle: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.masjidBankAccountCardFontSize,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.cardBackgroundColor,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  child: Text(
                    AppStrings.donatedAmountOne,
                    style: GoogleFonts.manrope(
                      color: AppColors.widgetLightPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.recordMyDonationSmallFont,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  child: Text(
                    AppStrings.donatedAmountTwo,
                    style: GoogleFonts.manrope(
                      color: AppColors.widgetLightPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.recordMyDonationSmallFont,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  child: Text(
                    AppStrings.donatedAmountThree,
                    style: GoogleFonts.manrope(
                      color: AppColors.widgetLightPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.recordMyDonationSmallFont,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  child: Text(
                    AppStrings.donatedAmountFour,
                    style: GoogleFonts.manrope(
                      color: AppColors.widgetLightPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.recordMyDonationSmallFont,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                AppStrings.recordMyDonationSenderName,
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.masjidBankAccountTitleSize,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppStrings.recordMyDonationDonateNameText,
                  hintStyle: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.masjidBankAccountCardFontSize,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.cardBackgroundColor,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: AppColors.cardButtonBackgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.recordMyDonationButtonText,
                  style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: AppDimensions.recorButtonFontSize,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
