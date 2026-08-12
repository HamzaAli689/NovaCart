import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/Appcolors.dart';
import '../logic.dart';
import '../widgets/product_card.dart'; // Apne project ke mutabiq product_card ka path check kar lein

class DiscoverBody extends StatelessWidget {
  final DashboardLogic controller;
  final bool isDarkMode;

  const DiscoverBody({Key? key, required this.controller, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Screen Title ---
            Text(
              "Discover Products",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 16),

            // --- Search Bar ---
            TextField(
              controller: controller.searchController,
              style: TextStyle(
                color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
              ),
              decoration: InputDecoration(
                hintText: "Search products by title...",
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.secondaryOrange),
                suffixIcon: Obx(() {
                  return controller.searchQuery.value.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () => controller.searchController.clear(),
                  )
                      : const SizedBox.shrink();
                }),
                filled: true,
                fillColor: isDarkMode ? AppColors.darkSurface : Colors.grey.withOpacity(0.08),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Categories Horizontal List ---
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: ['Fashion', 'Shoes', 'Electronics', 'Watch'].map((category) {
                  return Obx(() {
                    bool isSelected = controller.selectedCategory.value == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        selectedColor: AppColors.secondaryOrange,
                        backgroundColor: isDarkMode ? AppColors.darkSurface : Colors.grey.withOpacity(0.1),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : (isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        onSelected: (selected) {
                          if (selected) {
                            controller.selectCategory(category);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide.none,
                      ),
                    );
                  });
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // --- Filtered Products Grid ---
            Expanded(
              child: Obx(() {
                final products = controller.filteredProducts;

                if (products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded, size: 60, color: Colors.grey.withOpacity(0.5)),
                        const SizedBox(height: 12),
                        const Text(
                          "No products found!",
                          style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      context: context,
                      controller: controller,
                      isDarkMode: isDarkMode,
                      id: product['id'] ?? '',
                      imagePath: product['image'] ?? '',
                      title: product['title'] ?? '',
                      price: product['price'] ?? '',
                      rating: product['rating'] ?? '5.0',
                      storeName: product['storeName'] ?? 'NovaCart Store',
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
}