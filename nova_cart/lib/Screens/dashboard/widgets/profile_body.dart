import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_cart/Screens/login/view.dart';
import 'package:nova_cart/Screens/seller_admin/view.dart';
import '../../../widgets/Appcolors.dart';
import '../logic.dart';

class ProfileBody extends StatelessWidget {
  final DashboardLogic controller;
  final bool isDarkMode;

  const ProfileBody({Key? key, required this.controller, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. User Profile Header (Image, Name, Email, Settings Icon) ---
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.secondaryOrange, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage('Assets/images/O1.png'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(
                        controller.userName.value,
                        style: TextStyle(
                          color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      const SizedBox(height: 4),
                      const Text(
                        "hamza.ali@gmail.com",
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13.0),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.settings_outlined, color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy),
                  onPressed: () {
                    // Settings action
                  },
                ),
              ],
            ),
            const SizedBox(height: 30.0),

            // --- 2. UI Kit Style Options Card ---
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkSurface : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(color: isDarkMode ? Colors.white12 : Colors.grey.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  _buildProfileTile(
                    icon: Icons.location_on_outlined,
                    title: "Address",
                    isDarkMode: isDarkMode,
                    onTap: () {},
                  ),
                  _buildProfileTile(
                    icon: Icons.payment_outlined,
                    title: "Payment method",
                    isDarkMode: isDarkMode,
                    onTap: () {},
                  ),
                  _buildProfileTile(
                    icon: Icons.local_offer_outlined,
                    title: "Voucher",
                    isDarkMode: isDarkMode,
                    onTap: () {},
                  ),
                  _buildProfileTile(
                    icon: Icons.favorite_border_rounded,
                    title: "My Wishlist",
                    isDarkMode: isDarkMode,
                    onTap: () {},
                  ),
                  _buildProfileTile(
                    icon: Icons.star_border_rounded,
                    title: "Rate this app",
                    isDarkMode: isDarkMode,
                    onTap: () {},
                  ),
                  _buildProfileTile(
                    icon: Icons.logout_rounded,
                    title: "Log out",
                    isDarkMode: isDarkMode,
                    isLast: true,
                    textColor: Colors.redAccent,
                    iconColor: Colors.redAccent,
                    onTap: () {

                      // 1. Agar aap Firebase Auth use kar rahe hain to yeh line lagayein:
                      // await FirebaseAuth.instance.signOut();

                      // 2. Controller ka user role ya data clear karna ho to yahan kar sakte hain:
                      // controller.clearUserData();

                      // 3. Login screen par redirect karne ke liye GetX ka yeh method use karein:
                      // (Apni LoginScreen ka naam yahan replace kar lein)
                      Get.offAll(() => const LoginPage());
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // --- 3. Switch to Seller Account Container ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDarkMode ? Colors.white12 : Colors.black12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Switch to Seller Account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        "Create your store & list products",
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 11),
                      ),
                    ],
                  ),
                  Obx(() => Switch(
                    activeColor: AppColors.secondaryOrange,
                    value: controller.userRole.value == 'seller',
                    onChanged: (val) {
                      controller.toggleUserRole(val);
                      if (val) {
                        // Jab switch on ho to naye admin screen/page par navigate kar jayein
                        // Aap yahan apni target screen ka route de sakte hain:
                         Get.to(() => Seller_adminPage(controller: controller, isDarkMode: isDarkMode));
                      }
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable tile helper for the options card
  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required bool isDarkMode,
    required VoidCallback onTap,
    bool isLast = false,
    Color? textColor,
    Color? iconColor,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            color: iconColor ?? (isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy),
            size: 22,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: textColor ?? (isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: isLast
              ? null
              : const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: AppColors.textSecondary,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        ),
        if (!isLast)
          Divider(
            height: 1,
            thickness: 1,
            color: isDarkMode ? Colors.white12 : Colors.grey.withOpacity(0.1),
            indent: 20,
            endIndent: 20,
          ),
      ],
    );
  }
}