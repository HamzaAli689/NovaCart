import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/Appcolors.dart';
import '../logic.dart';
import 'category_item.dart';
import 'product_card.dart';

class HomeBody extends StatelessWidget {
  final DashboardLogic controller;
  final bool isDarkMode;

  const HomeBody({Key? key, required this.controller, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.secondaryOrange, width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('Assets/images/O1.png'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back,",
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 12.0, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 2),
                        Obx(() => Text(
                          "Hello, ${controller.userName.value} 👋",
                          style: TextStyle(
                            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildHeaderIcon(
                      icon: Icons.notifications_none_rounded,
                      isDarkMode: isDarkMode,
                      onTap: () => Get.snackbar("Notifications", "No new notifications"),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24.0),

            // --- UI Kit Style Banner Card (Replacing Search) ---
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.primaryNavy,
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
                      child: Image.asset('Assets/images/O1.png', fit: BoxFit.cover, width: 170),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Autumn Collection\n2022",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryOrange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Discover",
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // Categories
            Text(
              "Categories",
              style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy, fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              height: 95,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryItem(title: "Fashion", icon: Icons.checkroom_rounded, isDarkMode: isDarkMode, controller: controller),
                  CategoryItem(title: "Electronics", icon: Icons.devices_rounded, isDarkMode: isDarkMode, controller: controller),
                  CategoryItem(title: "Shoes", icon: Icons.snowboarding_rounded, isDarkMode: isDarkMode, controller: controller),
                  CategoryItem(title: "Groceries", icon: Icons.shopping_basket_rounded, isDarkMode: isDarkMode, controller: controller),
                  CategoryItem(title: "Beauty", icon: Icons.auto_awesome_rounded, isDarkMode: isDarkMode, controller: controller),
                ],
              ),
            ),
            const SizedBox(height: 20.0),

            // Products Grid
            Text(
              "Marketplace Products",
              style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy, fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12.0),
            Obx(() {
              final products = controller.filteredProducts;
              if (products.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(child: Text("No products found in this category.", style: TextStyle(color: Colors.grey))),
                );
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    context: context,
                    controller: controller,
                    isDarkMode: isDarkMode,
                    id: product['id'] ?? index.toString(),
                    imagePath: product['image'] ?? 'Assets/images/O1.png',
                    title: product['title'] ?? 'No Title',
                    price: product['price'] ?? '\$0.00',
                    rating: product['rating'] ?? '5.0',
                    storeName: product['storeName'] ?? 'Store',
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcon({required IconData icon, required bool isDarkMode, bool hasBadge = false, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
          shape: BoxShape.circle,
          border: Border.all(color: isDarkMode ? Colors.white12 : Colors.black12),
        ),
        child: Stack(
          children: [
            Icon(icon, size: 20, color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy),
            if (hasBadge)
              Positioned(
                right: 0,
                top: 0,
                child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.secondaryOrange, shape: BoxShape.circle)),
              ),
          ],
        ),
      ),
    );
  }
}