import 'package:flutter/material.dart';
import 'Appcolors.dart'; // Apne project ke path ke mutabiq import check kar lena

class OnboardingPageItem extends StatelessWidget {
  final bool isDarkMode;
  final String imagePath;
  final String heading;
  final String description;
  final double imageHeight;

  const OnboardingPageItem({
    Key? key,
    required this.isDarkMode,
    required this.imagePath,
    required this.heading,
    required this.description,
    required this.imageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: imageHeight,
          fit: BoxFit.contain,
        ),

        const SizedBox(height: 40.0),

        Text(
          heading,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12.0),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14.0,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}