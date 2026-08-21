import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/Appcolors.dart';

class ProfessionalHomeBody extends StatelessWidget {
  final bool isDarkMode;
  const ProfessionalHomeBody({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Professional Hard-coded UI Products for Stunning Screenshots
    final List<Map<String, dynamic>> proProducts = [
      {
        'title': 'Nike Air Zoom Pegasus',
        'price': '\$120.00',
        'image': 'Assets/images/shoe1.png', // Apni image ka path yahan dein
        'rating': '4.8',
        'store': 'Nike Official',
      },
      {
        'title': 'Wireless Pro Headphones',
        'price': '\$85.00',
        'image': 'Assets/images/headphone1.png',
        'rating': '4.9',
        'store': 'Tech Gadgets',
      },
      {
        'title': 'Casual Oversized Hoodie',
        'price': '\$45.00',
        'image': 'Assets/images/hoodie1.png',
        'rating': '4.7',
        'store': 'Urban Wear',
      },
      {
        'title': 'Smart Fitness Watch Pro',
        'price': '\$150.00',
        'image': 'Assets/images/watch1.png',
        'rating': '4.6',
        'store': 'Gadget Store',
      },
    ];

    final List<String> categories = ['All', 'Fashion', 'Electronics', 'Shoes', 'Beauty'];
    final RxInt selectedCatIndex = 0.obs;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 1. SEARCH BAR ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(AppColors.radiusButton),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
              decoration: InputDecoration(
                hintText: "Search unique products...",
                hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                icon: const Icon(Icons.search_rounded, color: AppColors.secondaryOrange),
                border: InputBorder.none,
                suffixIcon: const Icon(Icons.tune_rounded, color: AppColors.textSecondary, size: 20),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // --- 2. PROFESSIONAL BANNER WITH BACKGROUND IMAGE & OVERLAY ---
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppColors.radiusCard),
              image: const DecorationImage(
                image: AssetImage('Assets/images/banner_bg.png'), // Yahan apni banner background image ka path dein
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppColors.radiusCard),
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryNavy.withOpacity(0.92),
                    AppColors.primaryNavy.withOpacity(0.4),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryOrange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "SPECIAL OFFER",
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Super Summer Sale",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Get up to 50% off on all new items",
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // --- 3. CATEGORIES HORIZONTAL LIST ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                ),
              ),
              const Text("See All", style: TextStyle(color: AppColors.secondaryOrange, fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelected = selectedCatIndex.value == index;
                  return GestureDetector(
                    onTap: () => selectedCatIndex.value = index,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.secondaryOrange : (isDarkMode ? AppColors.darkSurface : AppColors.lightSurface),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : (isDarkMode ? AppColors.textSecondary : AppColors.primaryNavy),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          const SizedBox(height: 24),

          // --- 4. FEATURED PRODUCTS GRID ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Featured Products",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                ),
              ),
              const Text("Popular", style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: proProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final product = proProducts[index];
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(AppColors.radiusCard),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isDarkMode ? AppColors.darkBackground : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset(
                                product['image'],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: isDarkMode ? AppColors.darkSurface : Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
                              ),
                              child: const Icon(Icons.favorite_border_rounded, size: 16, color: AppColors.wishlistActive),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product['store'],
                      style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product['price'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.priceText,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 14, color: AppColors.ratingStar),
                            const SizedBox(width: 2),
                            Text(
                              product['rating'],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}