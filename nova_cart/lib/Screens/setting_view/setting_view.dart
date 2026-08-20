import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/Appcolors.dart';

class SettingView extends StatelessWidget {
  final bool isDarkMode;

  const SettingView({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Icon(
                Icons.menu_rounded,
                size: 20,
                color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
              ),
            ),
          ),
        ),
        title: Text(
          "Setting",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: [
          _buildSettingItem(
            icon: Icons.language_rounded,
            title: "Language",
            isDarkMode: isDarkMode,
            onTap: () {
              // Language selection action
            },
          ),
          _buildSettingItem(
            icon: Icons.notifications_none_rounded,
            title: "Notification",
            isDarkMode: isDarkMode,
            onTap: () {
              // Notification settings action
            },
          ),
          _buildSettingItem(
            icon: Icons.description_outlined,
            title: "Terms of Use",
            isDarkMode: isDarkMode,
            onTap: () {
              // Terms of use action
            },
          ),
          _buildSettingItem(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            isDarkMode: isDarkMode,
            onTap: () {
              // Privacy policy action
            },
          ),
          _buildSettingItem(
            icon: Icons.chat_bubble_outline_rounded,
            title: "Chat support",
            isDarkMode: isDarkMode,
            onTap: () {
              // Chat support action
            },
          ),
        ],
      ),
    );
  }

  // Helper widget for setting rows
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required bool isDarkMode,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppColors.radiusCard),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusCard),
        ),
        leading: Icon(
          icon,
          color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}