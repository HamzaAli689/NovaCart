import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/Appcolors.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  final pageController = PageController();

  bool get isLastPage => selectedPageIndex.value == 2;

  void forwardAction() {
    if (isLastPage) {
      Get.offAllNamed('/login');
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // --- Top Bar: NovaCart Header Logo ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    isDarkMode ? 'Assets/images/OLTD.png' : 'Assets/images/OLTL.png',
                    height: 55.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),

              const SizedBox(height: 20.0),

              // --- Page View Slider (3 Custom Pages) ---
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.selectedPageIndex.value = index;
                  },
                  children: [
                    // Page 1: Fast & Easy Shopping
                    _buildOnboardingPage(
                      isDarkMode: isDarkMode,
                      imagePath: 'Assets/images/O1.png',
                      heading: "Shop Smarter",
                      description: "Discover thousands of premium products from trusted brands, all in one place. Enjoy a fast, simple, and secure shopping experience.",
                      imageHeight: 220.0,
                    ),

                    // Page 2: Exclusive Deals
                    _buildOnboardingPage(
                      isDarkMode: isDarkMode,
                      imagePath: 'Assets/images/O2.png',
                      heading: "Easy & Secure Checkout",
                      description: "Add your favorite items to the cart, pay securely, and track every order with confidence from checkout to delivery.",
                      imageHeight: 220.0,
                    ),

                    // Page 3: Start Your Journey (Theme-aware logo image)
                    _buildOnboardingPage(
                      isDarkMode: isDarkMode,
                      // Agar light ke liye alag image hai toh yahan condition laga lein (e.g., L1.png ya light 3D logo)
                      imagePath: isDarkMode ? 'Assets/images/L2.png' : 'Assets/images/L3.png',
                      heading: "Fast Delivery",
                      description: "Track your orders in real time and receive your purchases quickly, wherever you are.",
                      imageHeight: 180.0,
                    ),
                  ],
                ),
              ),

              // --- Bottom Indicators (Dots) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                      (index) => Obx(
                        () => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 8.0,
                      width: controller.selectedPageIndex.value == index ? 22.0 : 8.0,
                      decoration: BoxDecoration(
                        color: controller.selectedPageIndex.value == index
                            ? AppColors.secondaryOrange
                            : AppColors.navUnselected,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // --- Bottom Button & Sub-text ---
              Obx(
                    () => Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 54.0,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(AppColors.radiusButton),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondaryOrange.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: controller.forwardAction,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppColors.radiusButton),
                          ),
                        ),
                        child: Text(
                          controller.isLastPage ? "Get Started" : "Next",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    if (controller.isLastPage) ...[
                      const SizedBox(height: 10.0),
                      Text(
                        "Click 'Get Started' to go to the next screen.",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Page Layout Builder
  Widget _buildOnboardingPage({
    required bool isDarkMode,
    required String imagePath,
    required String heading,
    required String description,
    required double imageHeight,
  }) {
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