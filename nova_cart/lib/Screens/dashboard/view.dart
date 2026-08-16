import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_cart/Screens/dashboard/widgets/app_drawer.dart';
import 'package:nova_cart/Screens/dashboard/widgets/home_body.dart';
import 'package:nova_cart/Screens/dashboard/widgets/profile_body.dart';
import 'package:nova_cart/Screens/dashboard/widgets/discover_body.dart';
import '../../widgets/Appcolors.dart';
import '../cart/view.dart';
import 'logic.dart';

class DashboardPage extends StatelessWidget {
  final String? userId;
  DashboardPage({Key? key, this.userId}) : super(key: key);

  // Scaffold key taake kisi bhi screen (jaise ProfileBody) se drawer open kiya ja sake
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final DashboardLogic controller = Get.put(DashboardLogic());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final List<Widget> pages = [
      HomeBody(controller: controller, isDarkMode: isDarkMode, scaffoldKey: scaffoldKey,),     // Tab 0: Home
      DiscoverBody(controller: controller, isDarkMode: isDarkMode), // Tab 1: Discover
      CartView(isDarkMode: isDarkMode),                             // Tab 2: Cart
      ProfileBody(controller: controller, isDarkMode: isDarkMode, ), // Key pass kar di
    ];

    return Scaffold(
      key: scaffoldKey, // Scaffold ko key assign kar di
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,

      // --- Drawer attach kiya hai ---
      drawer: AppDrawer(
        controller: controller,
        isDarkMode: isDarkMode,
        onMenuSelected: (index) {
          controller.changeTabIndex(index);
        },
      ),

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
              BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: "Discover"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}