import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/Appcolors.dart';
import '../../setting_view/setting_view.dart';
import '../logic.dart';


class AppDrawer extends StatelessWidget {
  final DashboardLogic controller;
  final bool isDarkMode;
  final Function(int) onMenuSelected; // Navigation tab change karne ke liye

  const AppDrawer({
    Key? key,
    required this.controller,
    required this.isDarkMode,
    required this.onMenuSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: isDarkMode ? AppColors.darkSurface : Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- User Profile Header ---
              Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.secondaryOrange.withOpacity(0.2),
                    backgroundImage: const NetworkImage(
                      'Assets/images/profile.png', // Placeholder profile image
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dynamic User Name
                        Obx(() => Text(
                          controller.userName.value,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        const SizedBox(height: 2),
                        // Dynamic Firebase Email
                        Obx(() => Text(
                          controller.userEmail.value,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // --- Main Menu Items ---
              Obx(() {
                int currentIndex = controller.currentIndex.value;
                return Column(
                  children: [
                    _buildDrawerItem(
                      icon: Icons.home_rounded,
                      title: "Homepage",
                      isSelected: currentIndex == 0,
                      onTap: () {
                        onMenuSelected(0);
                        Get.back();
                      },
                      isDarkMode: isDarkMode,
                    ),
                    _buildDrawerItem(
                      icon: Icons.search_rounded,
                      title: "Discover",
                      isSelected: currentIndex == 1,
                      onTap: () {
                        onMenuSelected(1);
                        Get.back();
                      },
                      isDarkMode: isDarkMode,
                    ),
                    _buildDrawerItem(
                      icon: Icons.shopping_bag_outlined,
                      title: "My Order",
                      isSelected: false, // Agar order screen alag hai toh wahan route karein
                      onTap: () {
                        Get.back();
                        Get.snackbar("My Order", "Order screen coming soon!", backgroundColor: AppColors.secondaryOrange, colorText: Colors.white);
                      },
                      isDarkMode: isDarkMode,
                    ),
                    _buildDrawerItem(
                      icon: Icons.person_outline_rounded,
                      title: "My profile",
                      isSelected: currentIndex == 3,
                      onTap: () {
                        onMenuSelected(3);
                        Get.back();
                      },
                      isDarkMode: isDarkMode,
                    ),
                  ],
                );
              }),

              const SizedBox(height: 20),
              Divider(color: isDarkMode ? Colors.white12 : Colors.black12),
              const SizedBox(height: 10),

              // --- OTHER SECTION TITLE ---
              Text(
                "OTHER",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary.withOpacity(0.8),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 10),

              // --- Other Links ---
              _buildDrawerItem(
                icon: Icons.settings_outlined,
                title: "Setting",
                isSelected: false,
                onTap: () {
                  Get.to(SettingView(isDarkMode: isDarkMode,));
                  // Settings route ya action yahan lagayein
                },
                isDarkMode: isDarkMode,
              ),
              _buildDrawerItem(
                icon: Icons.mail_outline_rounded,
                title: "Support",
                isSelected: false,
                onTap: () {
                  Get.back();
                },
                isDarkMode: isDarkMode,
              ),
              _buildDrawerItem(
                icon: Icons.info_outline_rounded,
                title: "About us",
                isSelected: false,
                onTap: () {
                  Get.back();
                },
                isDarkMode: isDarkMode,
              ),

              const Spacer(),

              // --- Light / Dark Theme Switcher Button at Bottom ---
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.darkBackground : Colors.grey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: isDarkMode ? Colors.white12 : Colors.black12),
                ),
                child: Row(
                  children: [
                    // Light Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (isDarkMode) Get.changeThemeMode(ThemeMode.light);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: !isDarkMode ? (isDarkMode ? AppColors.darkSurface : Colors.white) : Colors.transparent,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: !isDarkMode
                                ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ]
                                : [],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.wb_sunny_rounded,
                                size: 16,
                                color: !isDarkMode ? AppColors.secondaryOrange : Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "Light",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: !isDarkMode ? (isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy) : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Dark Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (!isDarkMode) Get.changeThemeMode(ThemeMode.dark);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isDarkMode ? AppColors.darkSurface : Colors.transparent,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: isDarkMode
                                ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ]
                                : [],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.nightlight_round_outlined,
                                size: 16,
                                color: isDarkMode ? AppColors.secondaryOrange : Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "Dark",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widget for Drawer Menu Rows ---
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? (isDarkMode ? AppColors.darkBackground : Colors.grey.withOpacity(0.1))
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.secondaryOrange : AppColors.textSecondary,
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? (isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy)
                : AppColors.textSecondary,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        dense: true,
      ),
    );
  }
}