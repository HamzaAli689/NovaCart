import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/Appcolors.dart';
import 'logic.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardLogic controller = Get.put(DashboardLogic());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Alag alag screens jo index ke mutabiq switch hongi
    final List<Widget> pages = [
      _buildHomeBody(context, controller, isDarkMode), // Tab 0: Home
      _buildWishlistBody(controller, isDarkMode),     // Tab 1: Wishlist
      _buildCartBody(isDarkMode),                     // Tab 2: Cart
      _buildProfileBody(controller, isDarkMode),      // Tab 3: Profile
    ];

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      // IndexedStack lagane se tab switch hone par screen change hogi aur state bachi rahegi
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: pages,
      )),

      // --- Bottom Navigation Bar ---
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
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_rounded),
                label: "Wishlist",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- 1. Home Screen Body ---
  Widget _buildHomeBody(BuildContext context, DashboardLogic controller, bool isDarkMode) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Custom Top Header ---
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
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
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
                      onTap: () {
                        Get.snackbar("Notifications", "No new notifications");
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildHeaderIcon(
                      icon: Icons.shopping_bag_outlined,
                      isDarkMode: isDarkMode,
                      hasBadge: true,
                      onTap: () {
                        controller.changeTabIndex(2); // Go to Cart tab
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24.0),

            // --- Search & Filter Bar ---
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(AppColors.radiusCard),
                      border: Border.all(
                        color: isDarkMode ? Colors.white12 : Colors.black12,
                      ),
                    ),
                    child: TextField(
                      controller: controller.searchController,
                      style: TextStyle(
                        color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search products, brands...",
                        hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.secondaryOrange),
                        suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () => controller.searchController.clear(),
                        )
                            : const SizedBox.shrink()),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppColors.radiusCard),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune_rounded, color: Colors.white, size: 20),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isDarkMode ? AppColors.darkSurface : Colors.white,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: Wrap(
                            children: [
                              const Text("Filter Options", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const Divider(),
                              ListTile(title: const Text("Price: Low to High"), onTap: () => Get.back()),
                              ListTile(title: const Text("Price: High to Low"), onTap: () => Get.back()),
                              ListTile(title: const Text("Top Rated"), onTap: () => Get.back()),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24.0),

            // --- Promotional Banner ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppColors.radiusCard),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryOrange.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "SPECIAL OFFER",
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Super Summer Sale\nUp to 50% Off",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            Get.snackbar("Sale", "Exploring Super Summer Sale items!");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryNavy,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Shop Now", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    'Assets/images/L3.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24.0),

            // --- Categories Section ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See All",
                    style: TextStyle(color: AppColors.secondaryOrange, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),

            SizedBox(
              height: 95,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryItem("Fashion", Icons.checkroom_rounded, isDarkMode, controller),
                  _buildCategoryItem("Electronics", Icons.devices_rounded, isDarkMode, controller),
                  _buildCategoryItem("Shoes", Icons.snowboarding_rounded, isDarkMode, controller),
                  _buildCategoryItem("Groceries", Icons.shopping_basket_rounded, isDarkMode, controller),
                  _buildCategoryItem("Beauty", Icons.auto_awesome_rounded, isDarkMode, controller),
                ],
              ),
            ),

            const SizedBox(height: 20.0),

            // --- Popular Products Grid View ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Products",
                  style: TextStyle(
                    color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See All",
                    style: TextStyle(color: AppColors.secondaryOrange, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),

            Obx(() {
              final products = controller.filteredProducts;
              if (products.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(
                    child: Text("No products found in this category.", style: TextStyle(color: Colors.grey)),
                  ),
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
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductCard(
                    context: context,
                    controller: controller,
                    isDarkMode: isDarkMode,
                    id: product['id'],
                    imagePath: product['image'],
                    title: product['title'],
                    price: product['price'],
                    rating: product['rating'],
                  );
                },
              );
            }),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  // --- 2. Wishlist Screen Body ---
  Widget _buildWishlistBody(DashboardLogic controller, bool isDarkMode) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Wishlist",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                final favs = controller.favoriteProducts;
                if (favs.isEmpty) {
                  return const Center(
                    child: Text(
                      "Your wishlist is empty!",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: favs.length,
                  itemBuilder: (context, index) {
                    final item = favs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                        borderRadius: BorderRadius.circular(AppColors.radiusCard),
                        border: Border.all(color: isDarkMode ? Colors.white12 : Colors.black12),
                      ),
                      child: ListTile(
                        leading: Image.asset(item['image'], width: 40, fit: BoxFit.contain),
                        title: Text(
                          item['title'],
                          style: TextStyle(
                            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          item['price'],
                          style: const TextStyle(
                            color: AppColors.secondaryOrange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                          onPressed: () => controller.toggleWishlist(item['id']),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // --- 3. Cart Screen Body ---
  Widget _buildCartBody(bool isDarkMode) {
    return SafeArea(
      child: Center(
        child: Text(
          "Cart Screen",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
          ),
        ),
      ),
    );
  }

  // --- 4. Profile Screen Body ---
  Widget _buildProfileBody(DashboardLogic controller, bool isDarkMode) {
    return SafeArea(
      child: Center(
        child: Obx(() => Text(
          "Profile Screen (${controller.userName.value})",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
          ),
        )),
      ),
    );
  }

  Widget _buildHeaderIcon({
    required IconData icon,
    required bool isDarkMode,
    bool hasBadge = false,
    required VoidCallback onTap,
  }) {
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
            Icon(
              icon,
              size: 20,
              color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
            ),
            if (hasBadge)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryOrange,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, IconData icon, bool isDarkMode, DashboardLogic controller) {
    return Obx(() {
      bool isSelected = controller.selectedCategory.value == title;
      return GestureDetector(
        onTap: () => controller.selectCategory(title),
        child: Container(
          width: 80,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.secondaryOrange
                : (isDarkMode ? AppColors.darkSurface : AppColors.lightSurface),
            borderRadius: BorderRadius.circular(AppColors.radiusCard),
            border: Border.all(
              color: isSelected ? AppColors.secondaryOrange : (isDarkMode ? Colors.white12 : Colors.black12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white.withOpacity(0.2) : AppColors.secondaryOrange,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : (isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildProductCard({
    required BuildContext context,
    required DashboardLogic controller,
    required bool isDarkMode,
    required String id,
    required String imagePath,
    required String title,
    required String price,
    required String rating,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppColors.radiusCard),
        border: Border.all(color: isDarkMode ? Colors.white12 : Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(imagePath, fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Obx(() {
                    bool isFavorite = controller.wishlistItems.contains(id);
                    return GestureDetector(
                      onTap: () => controller.toggleWishlist(id),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isDarkMode ? AppColors.darkBackground : Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          size: 16,
                          color: isFavorite ? Colors.redAccent : Colors.grey,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: AppColors.secondaryOrange,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                        const SizedBox(width: 2),
                        Text(
                          rating,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}