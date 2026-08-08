import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nova_cart/Screens/dashboard/view.dart';

import '../../widgets/Appcolors.dart';
import '../Onboarding/Onboarding Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));

    // Check if user is already logged in via GetStorage
    bool isLoggedIn = box.read('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAll(DashboardPage());
    } else {
      Get.offAll(OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spacer to push the logo exactly to the middle center
              const Spacer(),

              // Dynamic Logo based on Theme (L4 for Dark Mode, L1 for Light Mode)
              Image.asset(
                isDarkMode ? 'Assets/images/L4.png' : 'Assets/images/L1.png',
                width: 240,
                height: 240,
                fit: BoxFit.contain,
              ),

              // Spacer to balance the layout and push footer to the bottom
              const Spacer(),

              // Bottom Section: Loading Indicator & Credit Text
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondaryOrange),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Created by ',
                        style: TextStyle(
                          color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textSecondary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        '♥',
                        style: TextStyle(
                          color: AppColors.wishlistActive,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        ' Hamza',
                        style: TextStyle(
                          color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}