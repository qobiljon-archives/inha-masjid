import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inha_masjid/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inha_masjid/utils/strings.dart';

final List<String> imgList = [
  'lib/assets/images/masjid_images/1.jpeg',
  'lib/assets/images/masjid_images/2.jpeg',
  'lib/assets/images/masjid_images/3.jpeg',
  'lib/assets/images/masjid_images/4.jpeg',
];

class AboutMasjid extends StatefulWidget {
  const AboutMasjid({super.key});

  @override
  createState() => _AboutMasjidState();
}

class _AboutMasjidState extends State<AboutMasjid> {
  int _currentPage = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 58, 10, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.aboutInhaMasjid,
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                AppStrings.aboutInhaMasjidDescription,
                style: GoogleFonts.manrope(),
              ),
              const SizedBox(height: 10),
              Text(
                AppStrings.masjidImages,
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
          items: imgList
              .map(
                (item) => Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      item,
                      width: 280,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imgList.length,
            (index) => Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? AppColors
                        .cardPrimaryButtonColor // Change this color for the active indicator
                    : AppColors
                        .textSecondary, // Change this color for the inactive indicator
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.contactInformation,
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_right),
                      SizedBox(width: 5),
                      Text(
                        AppStrings.muftiAsim,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.arrow_right),
                      SizedBox(width: 5),
                      Text(
                        AppStrings.qobiljon,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.arrow_right),
                      SizedBox(width: 5),
                      Text(AppStrings.otabek)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                AppStrings.location,
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                      const ClipboardData(text: AppStrings.address));
                },
                child: Text(
                  AppStrings.address,
                  style: GoogleFonts.manrope(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cardPrimaryButtonColor,
                    foregroundColor: AppColors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Exit'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
