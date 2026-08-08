import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/Appcolors.dart';
import '../../widgets/custom_textfield.dart';
import '../login/view.dart';
import 'logic.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controller initialize kar rahe hain
    final RegisterLogic controller = Get.put(RegisterLogic());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50.0),

              // Theme-Aware Centered Logo Container
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.darkSurface : AppColors.secondaryOrange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDarkMode ? Colors.white12 : Colors.transparent,
                      ),
                    ),
                    child: Image.asset(
                      isDarkMode ? 'Assets/images/L2.png' : 'Assets/images/L3.png',
                      height: 90.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35.0),

              // Title & Subtitle
              Text(
                'Create Account 🚀',
                style: TextStyle(
                  color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Join NovaCart for the best shopping experience',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14.0,
                ),
              ),

              const SizedBox(height: 32.0),

              // Full Name Input
              CustomTextField(
                controller: controller.nameController,
                label: 'Full Name',
                icon: Icons.person_outline_rounded,
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 16.0),

              // Email Input
              CustomTextField(
                controller: controller.emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 16.0),

              // Password Input
              Obx(() => CustomTextField(
                controller: controller.passwordController,
                label: 'Password',
                icon: Icons.lock_outline_rounded,
                isPassword: true,
                obscureText: controller.obscurePassword.value,
                onToggleVisibility: () => controller.obscurePassword.toggle(),
                isDarkMode: isDarkMode,
              )),

              const SizedBox(height: 16.0),

              // Confirm Password Input
              Obx(() => CustomTextField(
                controller: controller.confirmPasswordController,
                label: 'Confirm Password',
                icon: Icons.lock_reset_rounded,
                isPassword: true,
                obscureText: controller.obscureConfirmPassword.value,
                onToggleVisibility: () => controller.obscureConfirmPassword.toggle(),
                isDarkMode: isDarkMode,
              )),

              const SizedBox(height: 32.0),

              // Create Account Button with Loading State
              Obx(() => Container(
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
                  onPressed: controller.isLoading.value ? null : () => controller.signUp(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppColors.radiusButton),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                      : const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),

              const SizedBox(height: 10.0),

              // Footer Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Agar login screen par jana ho toh Get.toNamed('/login') use kar sakte hain
                      Get.to(LoginPage());
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: AppColors.secondaryOrange,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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