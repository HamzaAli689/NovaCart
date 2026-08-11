import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_cart/Screens/dashboard/widgets/cart_body.dart';
import 'package:nova_cart/Screens/dashboard/widgets/home_body.dart';
import 'package:nova_cart/Screens/dashboard/widgets/profile_body.dart';
import 'package:nova_cart/Screens/dashboard/widgets/wishlist_body.dart';
import '../../widgets/Appcolors.dart';
import 'logic.dart';


class DashboardPage extends StatelessWidget {
  final String? userId;
  const DashboardPage({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardLogic controller = Get.put(DashboardLogic());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final List<Widget> pages = [
      HomeBody(controller: controller, isDarkMode: isDarkMode),     // Tab 0: Home
      WishlistBody(controller: controller, isDarkMode: isDarkMode), // Tab 1: Wishlist
      CartBody(isDarkMode: isDarkMode),                             // Tab 2: Cart
      ProfileBody(controller: controller, isDarkMode: isDarkMode),  // Tab 3: Profile
    ];

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: pages,
      )),
      bottomNavigationBar: Obx(
            () => Container(
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.darkSurface : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTabIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppColors.secondaryOrange,
            unselectedItemColor: AppColors.textSecondary,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded),
                label: "Discover",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}