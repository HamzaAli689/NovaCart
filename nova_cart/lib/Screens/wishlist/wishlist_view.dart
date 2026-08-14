import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/Appcolors.dart';
import '../dashboard/logic.dart';

class WishlistView extends StatelessWidget {
  final DashboardLogic controller;
  final bool isDarkMode;

  const WishlistView({Key? key, required this.controller, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isDarkMode ? Colors.white24 : Colors.grey.withOpacity(0.2)),
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 16,
              color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
            ),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "My Wishlist",
          style: TextStyle(
            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.wishlistProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border_rounded, size: 64, color: Colors.grey.withOpacity(0.5)),
                const SizedBox(height: 16),
                Text(
                  "Your Wishlist is Empty!",
                  style: TextStyle(
                    color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Explore products and tap the heart icon to save them.",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          itemCount: controller.wishlistProducts.length,
          itemBuilder: (context, index) {
            final product = controller.wishlistProducts[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkSurface : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDarkMode ? Colors.white12 : Colors.grey.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product['image'] ?? '',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 70,
                        height: 70,
                        color: Colors.grey.withOpacity(0.2),
                        child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'] ?? 'Product Title',
                          style: TextStyle(
                            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "\$${product['price'] ?? '0.00'}",
                          style: const TextStyle(
                            color: AppColors.secondaryOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Remove from Wishlist Button
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.redAccent),
                    onPressed: () => controller.toggleWishlist(product),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}